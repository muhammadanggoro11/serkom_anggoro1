import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kpukom/global_widget/card_show_data.dart';
import 'package:kpukom/services/db_pemilih.dart';
import 'package:kpukom/utils/color_constant.dart';
import 'package:kpukom/utils/text_styles_constant.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({super.key});

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  late Future<List<Map>> _pemilihFuture;
  List<Map> _pemilihData = [];

  @override
  void initState() {
    super.initState();
    _loadPemilihData();
  }

  Future<void> _loadPemilihData() async {
    _pemilihFuture = DBPemilih.getAllPemilih().then((data) {
      _pemilihData = List<Map>.from(data);
      return _pemilihData;
    });
    setState(() {});
  }

  Future<void> _deletePemilih(String id, int index) async {
    await DBPemilih.deletePemilih(id);
    setState(() {
      _pemilihData.removeAt(index);
    });
  }

  void _showDeleteConfirmation(
      BuildContext context, String id, String name, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus $name?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deletePemilih(id, index);
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lihat Data", style: TextStylesConstant.nunitoHeading5),
        centerTitle: false,
        backgroundColor: ColorsConstant.maroon,
        foregroundColor: ColorsConstant.white,
      ),
      body: FutureBuilder<List<Map>>(
        future: _pemilihFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_pemilihData.isEmpty) {
            return const Center(child: Text("Tidak ada data"));
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4.0),
            padding: const EdgeInsets.all(12.0),
            itemCount: _pemilihData.length,
            itemBuilder: (context, index) {
              final pemilih = _pemilihData[index];
              return Dismissible(
                key: Key(pemilih["id"].toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Hapus'),
                        content: Text(
                            'Apakah Anda yakin ingin menghapus ${pemilih["namaLengkap"]}?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Tidak"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Ya"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  _deletePemilih(pemilih["id"].toString(), index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("${pemilih["namaLengkap"]} dihapus")),
                  );
                },
                child: GestureDetector(
                  onTap: () => _showDetailDialog(context, pemilih),
                  child: CardPemilih(pemilih: pemilih),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Map pemilih) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pemilih["namaLengkap"]),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtributPemilih(
                    namaAtribut: "NIK", value: Text(pemilih["nik"].toString())),
                AtributPemilih(
                    namaAtribut: "No.HP",
                    value: Text(pemilih["nomorHandphone"])),
                AtributPemilih(
                    namaAtribut: "Jenis Kelamin",
                    value: Text(pemilih["jenisKelamin"])),
                AtributPemilih(
                    namaAtribut: "Tanggal",
                    value: Text(DateFormat("dd MMMM yyyy").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            pemilih['tanggalPendataan'])))),
                AtributPemilih(
                    namaAtribut: "Alamat", value: Text(pemilih["alamatRumah"])),
                const SizedBox(height: 10),
                if (pemilih['gambar'] != null)
                  AtributPemilih(
                      namaAtribut: "Gambar",
                      value: _buildImageWidget(pemilih["gambar"])),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }
}

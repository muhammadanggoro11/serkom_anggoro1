import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPemilih extends StatelessWidget {
  final Map pemilih;

  const CardPemilih({
    Key? key,
    required this.pemilih,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AtributPemilih(
                namaAtribut: "NIK", value: Text(pemilih["nik"].toString())),
            const SizedBox(height: 3.0),
            AtributPemilih(
                namaAtribut: "Nama", value: Text(pemilih["namaLengkap"])),
            const SizedBox(height: 3.0),
            AtributPemilih(
                namaAtribut: "No.HP", value: Text(pemilih["nomorHandphone"])),
            const SizedBox(height: 3.0),
            AtributPemilih(
                namaAtribut: "Jenis Kelamin",
                value: Text(pemilih["jenisKelamin"])),
            const SizedBox(height: 3.0),
            AtributPemilih(
                namaAtribut: "Tanggal",
                value: Text(DateFormat("dd MMMM yyyy").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        pemilih['tanggalPendataan'])))),
            if (pemilih['gambar'] != null) _buildImageWidget(pemilih["gambar"]),
          ],
        ),
      ),
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

class AtributPemilih extends StatelessWidget {
  final String namaAtribut;
  final Widget value;

  const AtributPemilih({
    Key? key,
    required this.namaAtribut,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            namaAtribut,
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
        const Expanded(
          flex: 0,
          child: Text(
            ":   ",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        Expanded(
          flex: 3,
          child: value,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kpukom/global_widget/alert_widget.dart';
import 'package:kpukom/global_widget/date_picker_widget.dart';
import 'package:kpukom/global_widget/global_button_widget.dart';
import 'package:kpukom/global_widget/image_picker_widget.dart';
import 'package:kpukom/services/db_pemilih.dart';
import 'package:kpukom/utils/color_constant.dart';
import 'package:kpukom/utils/text_styles_constant.dart';
import 'package:kpukom/view/home_screen.dart';

class FormEntryScreen extends StatefulWidget {
  const FormEntryScreen({super.key});

  @override
  State<FormEntryScreen> createState() => _FormEntryScreenState();
}

class _FormEntryScreenState extends State<FormEntryScreen> {
  TextEditingController nik = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController nomorHandphone = TextEditingController();
  TextEditingController alamatRumah = TextEditingController();

  String? gambar;
  String? jenisKelamin;
  int? tanggalPendataan;
  String? lokasi;
  bool isLoading = false;

  Future<String> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    lokasi = position.toString();
    return lokasi!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Form Input Data", style: TextStylesConstant.nunitoHeading5),
        centerTitle: false,
        backgroundColor: ColorsConstant. maroon,
        foregroundColor: ColorsConstant.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Formulir Data Pemilih',
                style: TextStylesConstant.nunitoHeading4),
            const SizedBox(
              height: 8,
            ),
            Card(
              color: ColorsConstant.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    buildRowInputField("NIK", TextInputType.number, nik),
                    const SizedBox(height: 10.0),
                    buildRowInputField("Nama", TextInputType.text, namaLengkap),
                    const SizedBox(height: 10.0),
                    buildRowInputField(
                        "No. HP", TextInputType.number, nomorHandphone),
                    const SizedBox(height: 10.0),
                    buildGenderSelection(),
                    buildDateSelection(),
                    buildAlamatField(),
                    buildLocationButton(context),
                    const SizedBox(height: 15.0),
                    buildImagePicker(),
                    const SizedBox(height: 20.0),
                    buildSubmitButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowInputField(
      String label, dynamic keyboardType, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: 44.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGenderSelection() {
    return Row(
      children: [
        const Expanded(
          child: Text("Jenis Kelamin",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Row(
            children: [
              buildRadioOption("Laki-laki", "L"),
              buildRadioOption("Perempuan", "P"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRadioOption(String value, String label) {
    return Row(
      children: [
        Radio(
          activeColor: ColorsConstant.primary300,
          value: value,
          groupValue: jenisKelamin,
          onChanged: (value) {
            setState(() {
              jenisKelamin = value!;
            });
          },
        ),
        Text(label, style: const TextStyle(fontSize: 14.0)),
      ],
    );
  }

  Widget buildDateSelection() {
    return Row(
      children: [
        const Expanded(
          child: Text("Tanggal",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: DatePickerWidget(
            label: "",
            onChanged: (value) {
              tanggalPendataan = value.millisecondsSinceEpoch;
            },
          ),
        ),
      ],
    );
  }

  Widget buildAlamatField() {
    return Row(
      children: [
        const Expanded(
          child: Text("Alamat",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Container(
            height: 125.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            ),
            child: TextField(
              controller: alamatRumah,
              maxLines: 5,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLocationButton(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF800000), 
              border: Border.all(
                color: const Color(0xFF800000),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: GlobalButtonWidget(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await getLocation().then((value) {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Info'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[Text('$lokasi')],
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                alamatRumah.text = lokasi!;
                              });
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                });
                setState(() {
                  isLoading = false;
                });
              },
              text: 'Cek Lokasi',
              buttonColor: const Color(0xFF800000), 
              textColor: Colors.white, 
            ),
          ),
        ),
      ],
    );
  }
  
  Widget buildImagePicker() {
    return Row(
      children: [
        const Expanded(
          child: Text("Gambar",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ImagePickerWidget(
            label: "",
            onChanged: (value) {
              gambar = value;
            },
          ),
        ),
      ],
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: GlobalButtonWidget(
        onTap: () async {
          try {
            int nikValue = int.parse(nik.text);
            String? nama =
                namaLengkap.text.isNotEmpty ? namaLengkap.text : null;
            String? nomorHP =
                nomorHandphone.text.isNotEmpty ? nomorHandphone.text : null;
            String? alamat =
                alamatRumah.text.isNotEmpty ? alamatRumah.text : null;
            String? gambarValue = gambar;

            bool isRegistered = await DBPemilih.isNikRegistered(nikValue);
            if (isRegistered) {
              AlertBannerWidgets.fail(context, 'NIK sudah terdaftar');
            } else {
              await DBPemilih.createPemilih(
                nik: nikValue,
                namaLengkap: nama ?? "Unknown",
                nomorHandphone: nomorHP ?? "Unknown",
                jenisKelamin: jenisKelamin ?? "Unknown",
                tanggalPendataan:
                    tanggalPendataan ?? DateTime.now().millisecondsSinceEpoch,
                alamatRumah: alamat ?? "Unknown",
                gambar: gambarValue ?? "",
              );
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Data berhasil disimpan!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          clearFormFields();
                          Get.to(const HomeScreen());
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          } catch (e) {
            AlertBannerWidgets.fail(
                context, 'Gagal menyimpan data: ${e.toString()}');
          }
        },
        text: 'Submit',
        buttonColor: const Color(0xFF800000), 
        textColor: Colors.white, 
      ),
    );
  }

  void clearFormFields() {
    nik.clear();
    namaLengkap.clear();
    nomorHandphone.clear();
    alamatRumah.clear();
    jenisKelamin = null;
    tanggalPendataan = null;
    gambar = null;
    setState(() {});
  }
}

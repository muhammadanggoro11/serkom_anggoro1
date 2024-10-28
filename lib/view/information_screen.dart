import 'package:flutter/material.dart';
import 'package:kpukom/utils/color_constant.dart';
import 'package:kpukom/utils/text_styles_constant.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi", style: TextStylesConstant.nunitoHeading5),
        centerTitle: false,
        backgroundColor: ColorsConstant.maroon,
        foregroundColor: ColorsConstant.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kpu_logo.png'), 
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.075),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              SizedBox(height: 16),
              Text(
                'Komisi Pemilihan Umum (KPU)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Komisi Pemilihan Umum (KPU) adalah lembaga yang bertanggung jawab menyelenggarakan Pemilihan Umum (Pemilu) '
                'di Indonesia untuk memastikan proses yang jujur, adil, dan demokratis. '
                'Tugas KPU mencakup perencanaan, pelaksanaan, dan pengawasan tahapan pemilu, penyelesaian sengketa, serta pembinaan partai politik. '
                'KPU juga berperan dalam sosialisasi hak dan kewajiban masyarakat, serta menjamin integritas, transparansi, dan keamanan dalam pelaksanaan pemilu.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Jadwal Pemilu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pemilu 2024 di Indonesia terdiri atas dua tahapan, yaitu Pemilihan Legislatif (Pileg) dan Pemilihan Presiden (Pilpres). '
                'Pileg 2024 akan dilaksanakan pada tanggal 14 Februari 2024, sedangkan Pilpres 2024 akan dilaksanakan dalam dua tahap, yaitu:',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8), // Menambahkan jarak sebelum daftar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Putaran pertama: 14 Februari 2024',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '2. Putaran kedua (jika diperlukan): 21 Juni 2024',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Cara Mendaftar sebagai Pemilih',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Untuk mendaftar sebagai pemilih di Indonesia, Anda harus memenuhi syarat sebagai Warga Negara Indonesia '
                'yang sudah genap berumur 17 tahun atau lebih. Berikut adalah langkah-langkah untuk mendaftar sebagai pemilih:',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8), // Menambahkan jarak sebelum daftar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Pastikan Anda memiliki e-KTP yang masih berlaku.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '2. Datang ke Kantor Kecamatan atau Kelurahan setempat.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '3. Isi formulir pendaftaran pemilih yang disediakan oleh petugas.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '4. Serahkan formulir yang telah diisi dan e-KTP kepada pet ugas.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '5. Tunggu konfirmasi dari petugas bahwa Anda telah terdaftar sebagai pemilih.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Kontak KPU',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Alamat: Jl. Imam Bonjol No.29, Menteng, Jakarta Pusat, DKI Jakarta 10310\n'
                'Telepon: (021) 3141522\n'
                'Email: info@kpu.go.id\n'
                'Website: https://www.kpu.go.id',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
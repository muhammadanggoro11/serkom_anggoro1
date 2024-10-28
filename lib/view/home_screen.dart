import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpukom/global_widget/global_button_widget.dart';
import 'package:kpukom/utils/color_constant.dart';
import 'package:kpukom/utils/text_styles_constant.dart';
import 'package:kpukom/view/form_entry_screen.dart';
import 'package:kpukom/view/information_screen.dart';
import 'package:kpukom/view/show_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.maroon,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'KOMISI PEMILIHAN UMUM',
                style: TextStylesConstant.nunitoHeading5.copyWith(color: ColorsConstant.white),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/kpu_logo.png',
                height: 160,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 60,
              ),
              GlobalButtonWidget(
                text: 'Informasi',
                textColor: ColorsConstant.black, 
                buttonWidth: 300,
                buttonHeight: 50,
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const InformationScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GlobalButtonWidget(
                text: 'Form Entry',
                textColor: ColorsConstant.black, 
                buttonWidth: 300,
                buttonHeight: 50,
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const FormEntryScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GlobalButtonWidget(
                text: 'Lihat Data',
                textColor: ColorsConstant.black, 
                buttonWidth: 300,
                buttonHeight: 50,
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ShowDataScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GlobalButtonWidget(
                text: 'Keluar',
                textColor: ColorsConstant.black, 
                buttonWidth: 300,
                buttonHeight: 50,
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
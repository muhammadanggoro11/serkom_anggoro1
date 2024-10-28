import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpukom/utils/color_constant.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.maroon,
      body: Center(
        child: Image.asset(
          'assets/images/kpu_logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

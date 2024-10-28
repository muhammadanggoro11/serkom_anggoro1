import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpukom/view/information_screen.dart';
import 'view/form_entry_screen.dart';
import 'view/home_screen.dart';
import 'view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(
          name: '/form',
          page: () => const FormEntryScreen(),
        ),
        GetPage(
          name: '/informasi',
          page: () => const InformationScreen(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

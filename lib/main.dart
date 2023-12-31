import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/internet_injection/depedency_injection.dart';
import 'package:md3_auto_care/view/pages/splaceScreen.dart';

void main() {
  runApp(const MyApp());
  DepedencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const GetMaterialApp(
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
      title: 'Transportastion Rent',
      home: SplaceScreen(),

      // home: CekPage(),
    );
  }
}

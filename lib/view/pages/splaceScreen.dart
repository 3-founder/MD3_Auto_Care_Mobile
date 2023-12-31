import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/view/pages/homePage.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    super.initState();
    splace();
  }

  void splace() {
    Timer(Duration(seconds: 3), () {
      Get.offAll(HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo/md3_auto_care.png'),
                    fit: BoxFit.contain,
                  ),
                  // color: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }
}

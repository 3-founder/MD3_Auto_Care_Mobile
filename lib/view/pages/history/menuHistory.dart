import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/view/pages/history/historyInvoice.dart';
import 'package:md3_auto_care/view/pages/history/historyPenawaran.dart';
import 'package:md3_auto_care/view/pages/homePage.dart';

class MenuHistory extends StatelessWidget {
  const MenuHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih History",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(const HomePage());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const HistoryPenawaran());
                },
                child: const Text("History Penawaran"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const HistoryInvoice());
                },
                child: const Text("History Invoce"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

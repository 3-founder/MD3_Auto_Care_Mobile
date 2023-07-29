import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:md3_auto_care/view/pages/history/menuHistory.dart';
import 'package:md3_auto_care/view/pages/invoice/add_invoiceOnly.dart';
import 'package:md3_auto_care/view/pages/profileCompanyPage.dart';
import 'package:md3_auto_care/view/pages/quotation/quotaionPage.dart';
import 'package:md3_auto_care/view/pages/signaturePage.dart';

class ItemHome {
  Widget createSignature(bool isMobile) {
    return InkWell(
      onTap: () async {
        Get.to(SignaturePage());
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCFCFC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: isMobile ? 65 : 100,
                height: isMobile ? 65 : 100,
                child: Center(
                    child: Lottie.asset("assets/lottie/signature.json"))),
            const SizedBox(height: 10),
            Text(
              "Tambah\nTanda Tangan",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget createQuotation(bool isMobile) {
    return InkWell(
      onTap: () async {
        Get.to(QuotationPage(
          edit: false,
          idPenawaran: 0,
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCFCFC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: isMobile ? 65 : 100,
                height: isMobile ? 65 : 100,
                child:
                    Center(child: Lottie.asset("assets/lottie/kutipan.json"))),
            const SizedBox(height: 10),
            Text(
              "Buat\nPenawaran",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget createInvoice(bool isMobile) {
    return InkWell(
      onTap: () async {
        Get.to(AddInvoiceOnly(
          edit: false,
          idInvoice: 0,
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCFCFC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isMobile ? 55 : 100,
              height: isMobile ? 55 : 100,
              child: Center(
                child: Lottie.asset("assets/lottie/buat-invoice.json"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Buat\nPenawaran",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget history(bool isMobile) {
    return InkWell(
      onTap: () async {
        Get.to(MenuHistory());
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCFCFC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: isMobile ? 65 : 100,
                height: isMobile ? 65 : 100,
                child:
                    Center(child: Lottie.asset("assets/lottie/history.json"))),
            const SizedBox(height: 10),
            Text(
              "History Penawaran\ndan Invoice",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget profile(bool isMobile) {
    return InkWell(
      onTap: () async {
        Get.to(ProfileCompanyPage());
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCFCFC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: isMobile ? 65 : 100,
                height: isMobile ? 65 : 100,
                child: Center(
                    child:
                        Lottie.asset("assets/lottie/profile-perusahaan.json"))),
            const SizedBox(height: 10),
            Text(
              "Profile\nPerusahaan",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

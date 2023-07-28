import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/provider/invoiceOnlyProvider.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class InvoiceOnlyController {
  void postQuotation(
    String noInvoice,
    String yth,
    String sales,
    String tanggal,
    String tanggalJatuhTempo,
    String poNo,
    String diskon,
    String ongkosKirim,
    String cashback,
    String metodePembayaran,
    String namabank,
    String noRekening,
    String atasNamaRekening,
    int idTandaTangan,
  ) {
    try {
      InvoiceOnlyProvider()
          .postInvoiceOnly(
        noInvoice,
        yth,
        sales,
        tanggal,
        tanggalJatuhTempo,
        poNo,
        diskon,
        ongkosKirim,
        cashback,
        metodePembayaran,
        namabank,
        noRekening,
        atasNamaRekening,
        idTandaTangan,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          // var getIdInvoice = response.body['data'];
          // Get.offUntil(
          //   MaterialPageRoute(
          //     builder: (context) => DataProduct(
          //       idPenawaran: getIdPenawaran['id'],
          //     ),
          //   ),
          //   (Route<dynamic> route) => route.isFirst,
          // );
        } else {
          SnackbarWidget().snackbarDanger(response.body['message']);
          print(response.body);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

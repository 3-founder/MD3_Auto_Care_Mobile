import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/provider/invoiceOnlyProvider.dart';
import 'package:md3_auto_care/provider/productInvoiceOnlyProvider.dart';
import 'package:md3_auto_care/view/pages/invoice/data_invoiceOnly.dart';
import 'package:md3_auto_care/view/pages/product/data_product.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class ProductInvoiceOnlyController {
  void postProductInvoiceOnly(
    String deskripsiBarang,
    String qty,
    String harga,
    String total,
    String idInvoiceOnly,
  ) {
    try {
      ProductInvoiceOnlyProvider()
          .postProductInvoiceOnly(
        deskripsiBarang,
        qty,
        harga,
        total,
        idInvoiceOnly,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          // var getIdInvoice = response.body['data'];
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => DataInvoiceOnly(
                idInvoice: int.parse(idInvoiceOnly),
              ),
            ),
            (Route<dynamic> route) => route.isFirst,
          );
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

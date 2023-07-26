import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md3_auto_care/provider/productProvider.dart';
import 'package:md3_auto_care/view/pages/product/data_product.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class ProductController {
  void postProduct(
    String productItem,
    String tipeItem,
    String kemasan,
    String tipeKemasan,
    String mesin,
    String tipeMesin,
    String harga,
    int idPenawaran,
    String typeProduct,
  ) {
    try {
      ProductProvider()
          .postProduct(
        productItem,
        tipeItem,
        kemasan,
        tipeKemasan,
        mesin,
        tipeMesin,
        harga,
        idPenawaran,
        typeProduct,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => DataProduct(
                idPenawaran: idPenawaran,
              ),
            ),
            (Route<dynamic> route) => route.isFirst,
          );
        } else {
          SnackbarWidget().snackbarError(response.body['message']);
          print(response.statusCode);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

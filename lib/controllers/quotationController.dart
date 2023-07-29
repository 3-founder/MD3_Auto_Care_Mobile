import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:md3_auto_care/provider/quotationProvider.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/view/pages/product/data_product.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class QuotationController extends GetxController {
  void postQuotation(
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tanggal,
    int idUserSignature,
  ) {
    try {
      QuotationProvider()
          .postQuotation(
        noPenawaran,
        halPenawaran,
        namaCustomer,
        tanggal,
        idUserSignature,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          var getIdPenawaran = response.body['data'];
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => DataProduct(
                idPenawaran: getIdPenawaran['id'],
              ),
            ),
            (Route<dynamic> route) => route.isFirst,
          );
          // Get.off(DataTransportationPage(
          //   id_customer: getIdCus['id'],
          //   isBack: 'false',
          // ));
        } else {
          SnackbarWidget().snackbarDanger(response.body['message']);
          print(response.body);
        }
      });
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }

  void updateQuotation(
    int idPenawaran,
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tanggal,
    int idUserSignature,
  ) {
    try {
      QuotationProvider()
          .updateQuotation(
        idPenawaran,
        noPenawaran,
        halPenawaran,
        namaCustomer,
        tanggal,
        idUserSignature,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          // var getIdPenawaran = response.body['data'];
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => DataProduct(
                idPenawaran: idPenawaran,
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

  Future<Map<String, dynamic>?> getProductPenawaran(int idPenawaran) async {
    String url = "$baseUrl/product-penawaran/$idPenawaran";
    var result;

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        result = json.decode(response.body)['data'];
        return result;
      } else {
        print(response.body);
      }
      return result;
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }
}

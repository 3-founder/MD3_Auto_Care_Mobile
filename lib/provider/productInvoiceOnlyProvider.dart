import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class ProductInvoiceOnlyProvider extends GetConnect {
  String url = "$baseUrl/invoice-only-product";
  String urlUpdate = "$baseUrl/invoice-only-product-update";

  Future<Response> postProductInvoiceOnly(
    String deskripsiBarang,
    String qty,
    String harga,
    String total,
    String idInvoiceOnly,
  ) async {
    final body = json.encode({
      "deskripsi_barang": deskripsiBarang,
      "qty": qty,
      "harga": harga,
      "total": total,
      "id_invoice_only": idInvoiceOnly,
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }

  Future<Response> updateProductInvoiceOnly(
    int idProduct,
    String deskripsiBarang,
    String qty,
    String harga,
    String total,
    String idInvoiceOnly,
  ) async {
    final body = json.encode({
      "deskripsi_barang": deskripsiBarang,
      "qty": qty,
      "harga": harga,
      "total": total,
      "id_invoice_only": idInvoiceOnly,
    });

    return post(
      '$urlUpdate/$idProduct',
      body,
      headers: {'Accept': 'application/json'},
    );
  }
}

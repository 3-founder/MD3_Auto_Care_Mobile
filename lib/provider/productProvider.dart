import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class ProductProvider extends GetConnect {
  String url = "$baseUrl/product-penawaran";
  String urlUpdate = "$baseUrl/edit-product-penawaran";

  Future<Response> postProduct(
    String productItem,
    String tipeItem,
    String kemasan,
    String tipeKemasan,
    String mesin,
    String tipeMesin,
    String harga,
    int idPenawaran,
    String typeProduct,
  ) async {
    final body = json.encode({
      "produk_item": productItem,
      "tipe_item": tipeItem,
      "kemasan": kemasan,
      "tipe_kemasan": tipeKemasan,
      "mesin": mesin,
      "tipe_mesin": tipeMesin,
      "harga": harga,
      "id_penawaran": '$idPenawaran',
      "type_product": typeProduct,
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }

  Future<Response> updateProduct(
    int idProductPenawaran,
    String productItem,
    String tipeItem,
    String kemasan,
    String tipeKemasan,
    String mesin,
    String tipeMesin,
    String harga,
    int idPenawaran,
    String typeProduct,
  ) async {
    final body = json.encode({
      "produk_item": productItem,
      "tipe_item": tipeItem,
      "kemasan": kemasan,
      "tipe_kemasan": tipeKemasan,
      "mesin": mesin,
      "tipe_mesin": tipeMesin,
      "harga": harga,
      "id_penawaran": '$idPenawaran',
      "type_product": typeProduct,
    });

    return post(
      "$urlUpdate/$idProductPenawaran",
      body,
      headers: {'Accept': 'application/json'},
    );
  }
}

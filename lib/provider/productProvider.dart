import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class ProductProvider extends GetConnect {
  String url = "$baseUrl/product-penawaran";
  String urlUpdate = "$baseUrl/edit-transportation";

  Future<Response> postProduct(
    String productItem,
    String tipeItem,
    String kemasan,
    String tipeKemasan,
    String mesin,
    String tipeMesin,
    String harga,
    int idPenawaran,
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
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }
}

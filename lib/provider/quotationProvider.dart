import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class QuotationProvider extends GetConnect {
  String url = "$baseUrl/penawaran";
  String urlUpdate = "$baseUrl/edit-penawaran";

  Future<Response> postQuotation(
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tangal,
    int idUserSignature,
  ) async {
    final body = json.encode({
      'no_penawaran': noPenawaran,
      'hal_penawaran': halPenawaran,
      'nama_customer': namaCustomer,
      'tanggal': tangal,
      'id_user_signature': idUserSignature,
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }

  Future<Response> updateQuotation(
    int idPenawaran,
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tangal,
    int idUserSignature,
  ) async {
    final body = json.encode({
      'no_penawaran': noPenawaran,
      'hal_penawaran': halPenawaran,
      'nama_customer': namaCustomer,
      'tanggal': tangal,
      'id_user_signature': idUserSignature,
    });

    return post(
      "$urlUpdate/$idPenawaran",
      body,
      headers: {'Accept': 'application/json'},
    );
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class QuotationProvider extends GetConnect {
  String url = "$baseUrl/penawaran";
  String urlUpdate = "$baseUrl/edit-customer";

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
    int id_customer,
    String kutipan_sewa,
    String nama_cus,
    String email,
    String nama_perusahaan,
    String kota,
    String detail_alamat,
    String pos,
    String tanggal,
    String no_quotation,
    String no_hp,
    String komentar,
    String total_harga,
    int id_user_ttd,
  ) async {
    final body = json.encode({
      'kutipan_sewa': kutipan_sewa,
      'nama_customer': nama_cus,
      'email': email,
      'nama_perusahaan': nama_perusahaan,
      'kota': kota,
      'nama_jalan': detail_alamat,
      'kode_pos': pos,
      'no_hp': no_hp,
      'tanggal': tanggal,
      'no_quotation': no_quotation,
      'komentar': komentar,
      'total_harga': total_harga,
      'id_user': id_user_ttd,
    });

    return post('$urlUpdate/$id_customer', body,
        headers: {'Accept': 'application/json'});
  }
}

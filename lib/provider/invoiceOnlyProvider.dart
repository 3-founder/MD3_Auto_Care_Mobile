import 'dart:convert';

import 'package:get/get.dart';
import 'package:md3_auto_care/utils/base_url.dart';

class InvoiceOnlyProvider extends GetConnect {
  String url = "$baseUrl/invoice-only";

  Future<Response> postInvoiceOnly(
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
  ) async {
    final body = json.encode({
      "no_invoice": noInvoice,
      "yth": yth,
      "sales": sales,
      "tanggal": tanggal,
      "tanggal_jatuh_tempo": tanggalJatuhTempo,
      "po_no": poNo,
      "diskon": diskon,
      "ongkos_kirim": ongkosKirim,
      "cashback": cashback,
      "metode_pembayaran": metodePembayaran,
      "nama_bank": namabank,
      "no_rekening": noRekening,
      "a_n_rekening": atasNamaRekening,
      "id_user_signature": idTandaTangan,
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }
}

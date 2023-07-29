import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:md3_auto_care/controllers/invoiceOnlyController.dart';
import 'package:md3_auto_care/formatter/thousandsSeparatorInputFormatter.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';
import 'package:http/http.dart' as http;

class AddInvoiceOnly extends StatefulWidget {
  bool edit;
  int idInvoice;
  AddInvoiceOnly({
    super.key,
    required this.edit,
    required this.idInvoice,
  });

  @override
  State<AddInvoiceOnly> createState() => _AddInvoiceOnlyState();
}

class _AddInvoiceOnlyState extends State<AddInvoiceOnly> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateTime2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var nomorInvoice = TextEditingController(text: '');
  var yth = TextEditingController(text: '');
  var sales = TextEditingController(text: '');
  var poNo = TextEditingController(text: '');
  var diskon = TextEditingController(text: '');
  var ongkosKirim = TextEditingController(text: '');
  var cashback = TextEditingController(text: '');
  String? valuePembayaran;
  var namaBankC = TextEditingController(text: '');
  var noRekeningC = TextEditingController(text: '');
  var namaRekeningC = TextEditingController(text: '');
  String? valueKetPembayaran;

  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: '', decimalDigits: 0);

  var isLoadingSimpan = false;

  List pembayaranList = [
    'transfer',
    'cash',
  ];

  List ketPembayaranList = [
    'lunas',
    'belum lunas',
  ];

  int? valueTtd;
  List<String> ttd_user = [
    "M.Fadil Adim",
  ];

  @override
  void initState() {
    super.initState();
    getDataSignature();
    if (widget.edit == true) {
      getInvoice(widget.idInvoice);
    }
  }

  var isLoading = false;
  List<dynamic> result = [];
  void getDataSignature() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    String url = '$baseUrl/user-signature';
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['message'];
        result = data;
        if (mounted) {
          setState(() {
            if (result.isEmpty) {
              SnackbarWidget().snackbarDanger(
                  "Data Tanda-tangan masih kosong, silahkan buat ttd.");
            }
          });
        }
      } else {
        print("Get data UserSignature gagal");
      }
    } catch (e) {
      debugPrint("$e");
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Get data Invoice
  var isLoadingInvoice = false;
  late Map<String, dynamic> dataInvoice;
  List<dynamic> invoce = [];
  void getInvoice(int idInvoice) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    String url = "$baseUrl/invoice-only/$idInvoice";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataInvoice = json.decode(response.body)['data'][0];
        // set data edit invoice
        nomorInvoice.text = dataInvoice['no_invoice'];
        yth.text = dataInvoice['yth'];
        sales.text = dataInvoice['sales'];
        dateTime = DateTime.parse(dataInvoice['tanggal']);
        dateTime2 = DateTime.parse(dataInvoice['tanggal_jatuh_tempo']);
        poNo.text = dataInvoice['po_no'] == null ? "" : dataInvoice['po_no'];
        diskon.text =
            dataInvoice['diskon'] == null ? "" : dataInvoice['diskon'];
        ongkosKirim.text = dataInvoice['ongkos_kirim'] == null
            ? ""
            : dataInvoice['ongkos_kirim'];
        cashback.text =
            dataInvoice['cashback'] == null ? "" : dataInvoice['cashback'];
        valuePembayaran = dataInvoice['metode_pembayaran'];
        namaBankC.text =
            dataInvoice['nama_bank'] == null ? "" : dataInvoice['nama_bank'];
        noRekeningC.text = dataInvoice['no_rekening'] == null
            ? ""
            : dataInvoice['no_rekening'];
        namaRekeningC.text = dataInvoice['a_n_rekening'] == null
            ? ""
            : dataInvoice['a_n_rekening'];
        valueTtd = dataInvoice['id_user_signature'];
        valueKetPembayaran = dataInvoice['ket_pembayaran'];
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.edit == true ? "Edit Invoice" : "Buat Invoice",
          style: const TextStyle(fontSize: 18),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: isLoading
          ? Center(
              child: Container(
                width: 60,
                height: 60,
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            )
          : isLoadingInvoice
              ? Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Lottie.asset('assets/lottie/loading.json'),
                  ),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // No Invoice
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Nomor Invoice",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: TextField(
                                    style: const TextStyle(
                                        color: Color(0xFF616161)),
                                    cursorColor: const Color(0xFF737373),
                                    decoration: const InputDecoration(
                                      hintText: 'Contoh. 01/VI/23/JM/MD3',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xFF515151)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xFFE4E4E4)),
                                      ),
                                    ),
                                    autocorrect: false,
                                    maxLines: 1,
                                    controller: nomorInvoice,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Yth
                          const SizedBox(height: 5),
                          const Text(
                            "Yth",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              onChanged: (value) {
                                yth.value = yth.value.copyWith(
                                  text: value.toUpperCase(),
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: value.length),
                                  ),
                                );
                              },
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. JELITA MOTOR',
                                hintStyle: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 13),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                              ),
                              autocorrect: false,
                              maxLines: 1,
                              controller: yth,
                              textInputAction: TextInputAction.next,
                            ),
                          ),

                          // Sales
                          const SizedBox(height: 5),
                          const Text(
                            "Sales",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. Shinta',
                                hintStyle: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 13),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                              ),
                              autocorrect: false,
                              maxLines: 1,
                              controller: sales,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          // Tanggal dan Tanggal Jatuh Tempo
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            // color: Colors.amber,
                            child: GridView.count(
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 10,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tanggal",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          final date = await pickerDate();
                                          if (date == null) return;
                                          final newDateTime = DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                          );
                                          if (mounted) {
                                            setState(() {
                                              dateTime = date;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xFFE4E4E4),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4))),
                                          height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                                  style: const TextStyle(
                                                      color: Color(0xFF515151),
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tanggal Jatuh Tempo",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          final date = await pickerDate2();
                                          if (date == null) return;
                                          final newDateTime = DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                          );
                                          if (mounted) {
                                            setState(() {
                                              dateTime2 = date;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xFFE4E4E4),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4))),
                                          height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  "${dateTime2.year}-${dateTime2.month}-${dateTime2.day}",
                                                  style: const TextStyle(
                                                      color: Color(0xFF515151),
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Po NO
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "PO No",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: TextField(
                                    style: const TextStyle(
                                        color: Color(0xFF616161)),
                                    cursorColor: const Color(0xFF737373),
                                    decoration: const InputDecoration(
                                      hintText: 'Boleh Kosong',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xFF515151)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xFFE4E4E4)),
                                      ),
                                    ),
                                    autocorrect: false,
                                    maxLines: 1,
                                    controller: poNo,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Diskon & Ongkos Kirim
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            // color: Colors.amber,
                            child: GridView.count(
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 10,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Diskon",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsSeparatorInputFormatter(),
                                          ],
                                          style: const TextStyle(
                                              color: Color(0xFF616161)),
                                          cursorColor: const Color(0xFF737373),
                                          decoration: const InputDecoration(
                                            hintText: 'Boleh kosong',
                                            prefixText: "Rp ",
                                            prefixStyle: TextStyle(
                                                color: Color(0xFF515151)),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF8F8F8F),
                                                fontSize: 13),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF515151)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFE4E4E4)),
                                            ),
                                          ),
                                          autocorrect: false,
                                          maxLines: 1,
                                          controller: diskon,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ongkos Kirim",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsSeparatorInputFormatter(),
                                          ],
                                          style: const TextStyle(
                                              color: Color(0xFF616161)),
                                          cursorColor: const Color(0xFF737373),
                                          decoration: const InputDecoration(
                                            hintText: 'Boleh kosong',
                                            prefixText: "Rp ",
                                            prefixStyle: TextStyle(
                                                color: Color(0xFF515151)),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF8F8F8F),
                                                fontSize: 13),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF515151)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFE4E4E4)),
                                            ),
                                          ),
                                          autocorrect: false,
                                          maxLines: 1,
                                          controller: ongkosKirim,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // total pembayaran
                          const Text(
                            "Cashback",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsSeparatorInputFormatter(),
                              ],
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: '40.000 / boleh kosong',
                                prefixText: "Rp ",
                                prefixStyle:
                                    TextStyle(color: Color(0xFF515151)),
                                hintStyle: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 13),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                              ),
                              autocorrect: false,
                              maxLines: 1,
                              controller: cashback,
                            ),
                          ),

                          // Tanda tangan
                          const SizedBox(height: 5),
                          const Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: valuePembayaran,
                              hint: const Text(
                                "Pilih metode pembayaran",
                                style: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 12),
                              ),
                              onChanged: ((value) {
                                if (mounted) {
                                  setState(() {
                                    valuePembayaran = value as String;
                                    print(valuePembayaran);
                                    namaBankC.text = '';
                                    noRekeningC.text = '';
                                    namaRekeningC.text = '';
                                  });
                                }
                              }),
                              items: pembayaranList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    "$item".toUpperCase(),
                                    style: const TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 13),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                            ),
                          ),

                          valuePembayaran == "cash"
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nama Bank
                                    const SizedBox(height: 15),
                                    const Text(
                                      "Nama Bank",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        onChanged: (value) {
                                          namaBankC.value =
                                              namaBankC.value.copyWith(
                                            text: value.toUpperCase(),
                                            selection:
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: value.length),
                                            ),
                                          );
                                        },
                                        style: const TextStyle(
                                            color: Color(0xFF616161)),
                                        cursorColor: const Color(0xFF737373),
                                        decoration: const InputDecoration(
                                          hintText: 'Contoh. BRI',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF8F8F8F),
                                              fontSize: 13),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF515151)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFFE4E4E4)),
                                          ),
                                        ),
                                        autocorrect: false,
                                        maxLines: 1,
                                        controller: namaBankC,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),

                                    // No rekening
                                    const SizedBox(height: 5),
                                    const Text(
                                      "No Rekening",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Color(0xFF616161)),
                                        cursorColor: const Color(0xFF737373),
                                        decoration: const InputDecoration(
                                          hintText: 'Contoh. 7285084067',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF8F8F8F),
                                              fontSize: 13),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFF515151),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFE4E4E4),
                                            ),
                                          ),
                                        ),
                                        autocorrect: false,
                                        maxLines: 1,
                                        controller: noRekeningC,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                      ),
                                    ),

                                    // Nama Bank
                                    const SizedBox(height: 5),
                                    const Text(
                                      "a.n Rekening",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        onChanged: (value) {
                                          namaRekeningC.value =
                                              namaRekeningC.value.copyWith(
                                            text: value.toUpperCase(),
                                            selection:
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: value.length),
                                            ),
                                          );
                                        },
                                        style: const TextStyle(
                                            color: Color(0xFF616161)),
                                        cursorColor: const Color(0xFF737373),
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Contoh. : M Taufan Athallah',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF8F8F8F),
                                              fontSize: 13),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF515151)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFFE4E4E4)),
                                          ),
                                        ),
                                        autocorrect: false,
                                        maxLines: 1,
                                        controller: namaRekeningC,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                          // Tanda tangan
                          const SizedBox(height: 5),
                          const Text(
                            "Tanda tangan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: valueTtd,
                              hint: const Text(
                                "Pilih yang bertanda tangan",
                                style: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 12),
                              ),
                              onChanged: ((value) {
                                setState(() {
                                  valueTtd = value as int;
                                });
                              }),
                              items: result.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    item['nama_lengkap'],
                                    style: const TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 13),
                                  ),
                                  value: item['id'],
                                );
                              }).toList(),
                            ),
                          ),

                          // keterangan pembayaran
                          const SizedBox(height: 5),
                          const Text(
                            "Keterangan Pembayaran",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF515151)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFE4E4E4)),
                                ),
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: valueKetPembayaran,
                              hint: const Text(
                                "Pilih Keterangan Pembayaran",
                                style: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 12),
                              ),
                              onChanged: ((value) {
                                if (mounted) {
                                  setState(() {
                                    valueKetPembayaran = value as String;
                                    print(valueKetPembayaran);
                                    namaBankC.text = '';
                                    noRekeningC.text = '';
                                    namaRekeningC.text = '';
                                  });
                                }
                              }),
                              items: ketPembayaranList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    "$item".toUpperCase(),
                                    style: const TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 13),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (mounted) {
                                  setState(() {
                                    isLoadingSimpan = true;
                                  });
                                }
                                final connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  debugPrint("NO INTERNET");
                                } else {
                                  if (valueTtd == null) {
                                    SnackbarWidget().snackbarDanger(
                                        "Tanda Tangan Wajib di pilih");
                                  } else {
                                    if (widget.edit != true) {
                                      InvoiceOnlyController().postInvoice(
                                        nomorInvoice.text,
                                        yth.text,
                                        sales.text,
                                        "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                        "${dateTime2.year}-${dateTime2.month}-${dateTime2.day}",
                                        poNo.text,
                                        diskon.text.replaceAll(',', ''),
                                        ongkosKirim.text.replaceAll(',', ''),
                                        cashback.text.replaceAll(',', ''),
                                        "$valuePembayaran",
                                        namaBankC.text,
                                        noRekeningC.text,
                                        namaRekeningC.text,
                                        valueTtd!,
                                        "$valueKetPembayaran",
                                      );
                                    } else {
                                      InvoiceOnlyController().updateInvoice(
                                        widget.idInvoice,
                                        nomorInvoice.text,
                                        yth.text,
                                        sales.text,
                                        "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                        "${dateTime2.year}-${dateTime2.month}-${dateTime2.day}",
                                        poNo.text,
                                        diskon.text.replaceAll(',', ''),
                                        ongkosKirim.text.replaceAll(',', ''),
                                        cashback.text.replaceAll(',', ''),
                                        "$valuePembayaran",
                                        namaBankC.text,
                                        noRekeningC.text,
                                        namaRekeningC.text,
                                        valueTtd!,
                                        "$valueKetPembayaran",
                                      );
                                    }
                                  }
                                }
                                if (mounted) {
                                  setState(() {
                                    isLoadingSimpan = false;
                                  });
                                }
                              },
                              child: Text(
                                  isLoadingSimpan
                                      ? 'Loading...'
                                      : widget.edit == true
                                          ? "Update"
                                          : 'Simpan',
                                  style: TextStyle(fontSize: 13)),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(1),
                                overlayColor: MaterialStateProperty.all(
                                    widget.edit == true
                                        ? const Color(0xFF3EA8D6)
                                        : Colors.green),
                                backgroundColor: MaterialStateProperty.all(
                                    widget.edit == true
                                        ? const Color(0xFF5DC3EF)
                                        : const Color(0xFF3FC633)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
  Future<DateTime?> pickerDate2() => showDatePicker(
        context: context,
        initialDate: dateTime2,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
}

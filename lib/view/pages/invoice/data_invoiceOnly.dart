import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:md3_auto_care/pdf/invoicePdf.dart';
import 'package:md3_auto_care/pdf/penawaranPdf.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/view/pages/product/add_product_invoiceOnly.dart';
import 'package:md3_auto_care/view/pages/product/add_product_quotation.dart';
import 'package:md3_auto_care/widget/dataInvoiceWidget.dart';
import 'package:md3_auto_care/widget/dataPenawaranWidget.dart';

class DataInvoiceOnly extends StatefulWidget {
  var idInvoice;
  DataInvoiceOnly({super.key, required this.idInvoice});

  @override
  State<DataInvoiceOnly> createState() => _DataInvoiceOnlyState();
}

class _DataInvoiceOnlyState extends State<DataInvoiceOnly> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

  @override
  void initState() {
    super.initState();
    getPenawaran(widget.idInvoice);
    getProductPenawaran(widget.idInvoice);
    getCompany();
  }

  // Get data penawaran
  var isLoading = false;
  late Map<String, dynamic> dataInvoice;
  List<dynamic> invoce = [];
  void getPenawaran(int idInvoice) async {
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
        // print('CEK Invoice : ${dataInvoice}');
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

  // Get Data product invoice
  int subTotalRp = 0;
  var isLoading2 = false;
  late Map<String, dynamic> dataProduct = {};
  List<dynamic> dataProductInvoice = [];
  void getProductPenawaran(int idInvoice) async {
    if (mounted) {
      setState(() {
        isLoading2 = true;
      });
    }

    String url = "$baseUrl/invoice-only-product/$idInvoice";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataProduct = json.decode(response.body)['data'];
        dataProductInvoice = dataProduct['invoice_only'];
        print(dataProductInvoice);
        // print(product);
        // print(cekTrans);
        // for (var i = 0; i < cekTrans.length; i++) {
        //   subTotalRp += int.parse(cekTrans[i]['harga']);
        // }
        // print("Sub Total = $subTotalRp");
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {
        isLoading2 = false;
      });
    }
  }

  // Get data company
  List<dynamic> company = [];
  void getCompany() async {
    if (mounted) {
      setState(() {
        isLoading2 = true;
      });

      String url = "$baseUrl/data-company";

      try {
        http.Response response = await http
            .get(Uri.parse(url), headers: {'Accept': 'application/json'});
        if (response.statusCode == 200) {
          company = json.decode(response.body)['data'];
          print(company);
        } else {
          print(response.body);
        }
      } catch (e) {
        print(e);
      }
    }
    if (mounted) {
      setState(() {
        isLoading2 = false;
      });
    }
  }

  // PopUp Quotation
  bool _isPopupVisibleQuotation = false;
  void _invoiceOnlyPopUp(
    int idInvoice,
    // header right From data invoice Only
    String yth,
    String sales,
    String tanggal,
    String noInvoice,
    String poNo,
    String tanggalJatuhTempo,
    String diskon,
    String ongkosKirim,
    String cashback,
    // Metode Pembayaran From data invoice Only
    String mPembayaran,
    String? atasNamaBank,
    String? noRekening,
    String? namaBank,
    String ttdDirektur,
    String ketPembayaran,
    // Company
    String logo,
    String namaCompany,
    String noHpCompany,
    String emailCompany,
    String alamatCompany,
    String kotaCompany,
    String provinsiCompany,
    // type generate
    bool generate,
  ) {
    setState(() {
      _isPopupVisibleQuotation = !_isPopupVisibleQuotation;
    });
    if (_isPopupVisibleQuotation) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                actions: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 45,
                        color: const Color(0xFFD0EDF9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Pilih",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isPopupVisibleQuotation =
                                            !_isPopupVisibleQuotation;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFFC0C0),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED6C6C),
                                ),
                                onPressed: () {
                                  InvoicePdf().printPdf(
                                    idInvoice,
                                    // header right From data invoice Only
                                    yth,
                                    sales,
                                    tanggal,
                                    noInvoice,
                                    poNo,
                                    tanggalJatuhTempo,
                                    diskon,
                                    ongkosKirim,
                                    cashback,
                                    // Metode Pembayaran From data invoice Only
                                    mPembayaran,
                                    atasNamaBank,
                                    noRekening,
                                    namaBank,
                                    ttdDirektur,
                                    ketPembayaran,
                                    // Company
                                    logo,
                                    namaCompany,
                                    noHpCompany,
                                    emailCompany,
                                    alamatCompany,
                                    kotaCompany,
                                    provinsiCompany,
                                    // type generate
                                    true,
                                  );
                                },
                                label: const Text("Generate Invoice"),
                                icon: const Icon(Icons.picture_as_pdf),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED6C6C),
                                ),
                                onPressed: () {
                                  InvoicePdf().printPdf(
                                    idInvoice,
                                    // header right From data invoice Only
                                    yth,
                                    sales,
                                    tanggal,
                                    noInvoice,
                                    poNo,
                                    tanggalJatuhTempo,
                                    diskon,
                                    ongkosKirim,
                                    cashback,
                                    // Metode Pembayaran From data invoice Only
                                    mPembayaran,
                                    atasNamaBank,
                                    noRekening,
                                    namaBank,
                                    ttdDirektur,
                                    ketPembayaran,
                                    // Company
                                    logo,
                                    namaCompany,
                                    noHpCompany,
                                    emailCompany,
                                    alamatCompany,
                                    kotaCompany,
                                    provinsiCompany,
                                    // type generate
                                    false,
                                  );
                                },
                                label: const Text("Share Quotation"),
                                icon: const Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Data Invoice",
          style: TextStyle(fontSize: 18),
        ),
        // actions: [
        //   invoce.isNotEmpty
        //       ? Container()
        //       : InkWell(
        //           onTap: () {
        //             Get.to(
        //               EditQuotationPage(
        //                 noQuotation: '${dataQuotation['no_quotation']}',
        //                 kutipanSewa: '${dataQuotation['kutipan_sewa']}',
        //                 namaCustomer: '${dataQuotation['nama_customer']}',
        //                 email: '${dataQuotation['email']}',
        //                 namaCompanyCustomer:
        //                     '${dataQuotation['nama_perusahaan']}',
        //                 kotaCustomer: '${dataQuotation['kota']}',
        //                 alamatCustomer: '${dataQuotation['nama_jalan']}',
        //                 kodePos: '${dataQuotation['kode_pos']}',
        //                 tanggal: '${dataQuotation['tanggal']}',
        //                 noHp: '${dataQuotation['no_hp']}',
        //                 komentar: '${dataQuotation['komentar']}',
        //                 idUserTtd: int.parse('${dataQuotation['id_user']}'),
        //                 idCustomer: int.parse('${dataQuotation['id']}'),
        //               ),
        //             );
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //               width: 70,
        //               decoration: BoxDecoration(
        //                   color: const Color(0xFF5FC4F0),
        //                   borderRadius: BorderRadius.circular(8)),
        //               child: const Center(
        //                 child: Text(
        //                   "Edit\nQuotation",
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         )
        // ],
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      bottomNavigationBar: Container(
        // height: cekTrans.isEmpty ? 65 : 108,
        height: 65,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 155,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      print("NO INTERNET");
                    } else {
                      Get.to(AddProductInvoiceOnly(
                        idProductInvoiceOnly: dataInvoice['id'].toString(),
                      ));
                    }
                  },
                  child: const Text(
                    'Tambah Produk',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(1),
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xFF3EA8D6)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF5DC3EF)),
                  ),
                ),
              ),
              dataProductInvoice.isEmpty
                  ? Container()
                  : const SizedBox(width: 10),
              dataProductInvoice.isEmpty
                  ? Container()
                  : SizedBox(
                      width: 155,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // cek Internet Connection
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.none) {
                            print("NO INTERNET");
                          } else {
                            _invoiceOnlyPopUp(
                              dataInvoice['id'],
                              dataInvoice['yth'],
                              dataInvoice['sales'],
                              dataInvoice['tanggal'],
                              dataInvoice['no_invoice'],
                              '${dataInvoice['po_no'] == null ? "null" : dataInvoice['po_no']}',
                              dataInvoice['tanggal_jatuh_tempo'],
                              dataInvoice['diskon'] == null
                                  ? "0"
                                  : dataInvoice['diskon'],
                              dataInvoice['ongkos_kirim'] == null
                                  ? "0"
                                  : dataInvoice['ongkos_kirim'],
                              dataInvoice['cashback'] == null
                                  ? "0"
                                  : dataInvoice['cashback'],
                              dataInvoice['metode_pembayaran'],
                              dataInvoice['a_n_rekening'],
                              dataInvoice['no_rekening'],
                              dataInvoice['nama_bank'],
                              dataInvoice['signature_user']['tanda_tangan'],
                              dataInvoice['ket_pembayaran'],
                              //Company
                              company[0]['logo'],
                              company[0]['nama_company'],
                              company[0]['no_hp'],
                              company[0]['email'],
                              company[0]['alamat'],
                              company[0]['kota'],
                              company[0]['provinsi'],
                              true,
                            );
                            // InvoicePdf().printPdf(
                            //   dataInvoice['id'],
                            //   dataInvoice['yth'],
                            //   dataInvoice['sales'],
                            //   dataInvoice['tanggal'],
                            //   dataInvoice['no_invoice'],
                            //   '${dataInvoice['po_no'] == null ? "null" : dataInvoice['po_no']}',
                            //   dataInvoice['tanggal_jatuh_tempo'],
                            //   dataInvoice['metode_pembayaran'],
                            //   dataInvoice['a_n_rekening'],
                            //   dataInvoice['no_rekening'],
                            //   dataInvoice['nama_bank'],
                            //   dataInvoice['signature_user']['tanda_tangan'],
                            //   //Company
                            //   company[0]['logo'],
                            //   company[0]['nama_company'],
                            //   company[0]['no_hp'],
                            //   company[0]['email'],
                            //   company[0]['alamat'],
                            //   company[0]['kota'],
                            //   company[0]['provinsi'],
                            //   true,
                            // );
                            // _quotationPopUp(
                            //   dataInvoice['id'],
                            //   dataInvoice['no_penawaran'],
                            //   dataInvoice['hal_penawaran'],
                            //   dataInvoice['nama_customer'],
                            //   dataInvoice['tanggal'],
                            //   dataInvoice['signature_user']['nama_lengkap'],
                            //   dataInvoice['signature_user']['tanda_tangan'],
                            //   company[0]['logo'],
                            //   company[0]['nama_company'],
                            //   company[0]['no_hp'],
                            //   company[0]['email'],
                            //   company[0]['provinsi'],
                            //   company[0]['kota'],
                            //   company[0]['alamat'],
                            // );
                          }
                        },
                        child: const Text('Generate Invoice',
                            style: TextStyle(fontSize: 12)),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(1),
                          overlayColor: MaterialStateProperty.all(
                              const Color(0xFFC34E4E)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFED6C6C)),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                width: 60,
                height: 60,
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            )
          : ListView(
              shrinkWrap: true,
              // physics: cekTrans.isEmpty
              //     ? const NeverScrollableScrollPhysics()
              //     : const AlwaysScrollableScrollPhysics(),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return DataInvoiceWidget().data(
                          dataInvoice['no_invoice'],
                          dataInvoice['yth'],
                          dataInvoice['sales'],
                          dataInvoice['tanggal'],
                          dataInvoice['tanggal_jatuh_tempo'],
                          dataInvoice['signature_user']['nama_lengkap'],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child:
                          // child: cekTrans.isEmpty
                          //     ? Column(
                          //         children: const [
                          //           SizedBox(height: 200),
                          //           Text("Transportation Masih Kosong!"),
                          //           Text(
                          //             "Silahkan Tambahkan Transportation\nTerlebih dahulu.",
                          //             textAlign: TextAlign.center,
                          //           ),
                          //         ],
                          //       )
                          //     : isLoadingDelete
                          //         ? Center(
                          //             child: Container(
                          //               width: 60,
                          //               height: 60,
                          //               child: Lottie.asset('assets/lottie/loading.json'),
                          //             ),
                          //           )
                          //         :
                          ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataProductInvoice.length,
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IgnorePointer(
                            ignoring:
                                // invoce.isNotEmpty ? true : false,
                                true,
                            child: Dismissible(
                              movementDuration: Duration.zero,
                              // key: Key(cekTrans[index]['id'].toString()),
                              key: Key("1"),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Hapus Transportasi'),
                                      content: Text(
                                          // 'Apakah Anda ingin menghapus ${cekTrans[index]['tipe_mobil']}?'),
                                          'Apakah Anda ingin menghapus tipe?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                false); // Return false to cancel dismissal
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                true); // Return true to proceed with dismissal
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              // onDismissed: invoce.isNotEmpty
                              //     ? null
                              //     : (direction) {
                              //         deleteTransportation(
                              //             cekTrans[index]['id']);
                              //         setState(() {
                              //           cekTrans.removeAt(index);
                              //         });
                              //       },
                              onDismissed: null,
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Icon(Icons.delete, color: Colors.white),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 115,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFB6B6B6)),
                                      borderRadius: BorderRadius.circular(7),
                                      // color:
                                      //     const Color(0xFFFFFFFF),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(7),
                                                topRight: Radius.circular(7)),
                                            color: Color(0xFFC3EDFF),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 185,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          '${dataProductInvoice[index]['deskripsi_barang']}'
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 21,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                const Color(
                                                                    0xFF5FC4F0),
                                                            elevation:
                                                                0, // Remove elevation
                                                          ),
                                                          onPressed: () {
                                                            // Get.to(
                                                            //   EditTransportation(
                                                            //     idTransportation:
                                                            //         int.parse('${cekTrans[index]['id']}'),
                                                            //     id_customer:
                                                            //         int.parse('${dataQuotation['id']}'),
                                                            //     tipeKendaraan:
                                                            //         '${cekTrans[index]['tipe_mobil']}',
                                                            //     lamaPenggunaan:
                                                            //         '${cekTrans[index]['lama_penggunaan']}',
                                                            //     jmlUnit:
                                                            //         '${cekTrans[index]['jumlah']}',
                                                            //     tanggalPenggunaan:
                                                            //         '${cekTrans[index]['tanggal_penggunaan']}',
                                                            //     harga:
                                                            //         '${cekTrans[index]['harga']}',
                                                            //     tujuanKendaraan:
                                                            //         '${cekTrans[index]['tujuan']}',
                                                            //   ),
                                                            // );
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: const Color(0xFFB6B6B6),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Jumlah",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${dataProductInvoice[index]['qty']} Barang',
                                                    style: const TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Harga",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp ${currencyFormatter.format(double.parse(dataProductInvoice[index]['harga']))}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: const Color(0xFFB6B6B6),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(""),
                                                  Text(
                                                    "Rp ${currencyFormatter.format(double.parse(dataProductInvoice[index]['total']))}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
    );
  }
}

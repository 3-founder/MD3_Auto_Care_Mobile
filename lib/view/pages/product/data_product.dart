import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:md3_auto_care/pdf/penawaranPdf.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/view/pages/product/add_product_quotation.dart';
import 'package:md3_auto_care/view/pages/quotation/quotaionPage.dart';
import 'package:md3_auto_care/widget/dataPenawaranWidget.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class DataProduct extends StatefulWidget {
  var idPenawaran;
  DataProduct({super.key, required this.idPenawaran});

  @override
  State<DataProduct> createState() => _DataProductState();
}

class _DataProductState extends State<DataProduct> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

  @override
  void initState() {
    super.initState();
    getPenawaran(widget.idPenawaran);
    getProductPenawaran(widget.idPenawaran);
    getCompany();
  }

  // Get data penawaran
  var isLoading = false;
  late Map<String, dynamic> dataPenawaran;
  List<dynamic> invoce = [];
  void getPenawaran(int idPenawaran) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    String url = "$baseUrl/penawaran/$idPenawaran";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataPenawaran = json.decode(response.body)['data'][0];
        // print('CEK Penawaran : ${dataPenawaran}');
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

  // Get Data product Penawaran
  int subTotalRp = 0;
  var isLoading2 = false;
  late Map<String, dynamic> dataProduct = {};
  late Map<String, dynamic> dataProductMain = {};
  List<dynamic> productMain = [];
  List<dynamic> productAdditional = [];
  void getProductPenawaran(int idPenawaran) async {
    if (mounted) {
      setState(() {
        isLoading2 = true;
      });
    }

    String url = "$baseUrl/product-penawaran/$idPenawaran";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataProduct = json.decode(response.body)['data'];
        dataProductMain = dataProduct['product_penawaran'];
        productMain = dataProductMain['main'];
        productAdditional = dataProductMain['additional'];
        print(productAdditional);
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

  // Delete Product Penawaran
  bool isLoadingDelete = false;
  void deleteTransportation(int id) async {
    if (mounted) {
      setState(() {
        isLoadingDelete = true;
      });
    }
    String url = "$baseUrl/delete-product-penawaran/$id";

    try {
      http.Response response = await http
          .delete(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var deleteTrans = json.decode(response.body);
        SnackbarWidget().snackbarSuccess(deleteTrans['message']);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        isLoadingDelete = false;
      });
    }
  }

  // PopUp Quotation
  bool _isPopupVisibleQuotation = false;
  void _quotationPopUp(
    int idPenawaran,
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tanggal,
    String namaTtd,
    String ttd,
    // Company
    String logoCompany,
    String namaCompany,
    String noHpCompany,
    String emailCompany,
    String provinsi,
    String kota,
    String alamat,
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
                                  PenawaranPdf().printPdf(
                                    idPenawaran,
                                    noPenawaran,
                                    halPenawaran,
                                    namaCustomer,
                                    tanggal,
                                    namaTtd,
                                    ttd,
                                    logoCompany,
                                    namaCompany,
                                    noHpCompany,
                                    emailCompany,
                                    provinsi,
                                    kota,
                                    alamat,
                                    true,
                                  );
                                },
                                label: const Text("Generate Quotation"),
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
                                  PenawaranPdf().printPdf(
                                    idPenawaran,
                                    noPenawaran,
                                    halPenawaran,
                                    namaCustomer,
                                    tanggal,
                                    namaTtd,
                                    ttd,
                                    logoCompany,
                                    namaCompany,
                                    noHpCompany,
                                    emailCompany,
                                    provinsi,
                                    kota,
                                    alamat,
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
          "Data Penawaran",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          //   invoce.isNotEmpty
          //       ? Container()
          //       :
          InkWell(
            onTap: () {
              Get.to(
                QuotationPage(
                  edit: true,
                  idPenawaran: dataPenawaran['id'],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: const Color(0xFF5FC4F0),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    "Edit Penawaran",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
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
                      Get.to(
                        AddProductQuotation(
                          idPenawaran: widget.idPenawaran,
                          edit: false,
                          typeProduct: "null",
                          indexProduct: 0,
                          idProduct: 0,
                        ),
                      );
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
              productMain.isEmpty ? Container() : const SizedBox(width: 10),
              productMain.isEmpty
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
                            _quotationPopUp(
                              dataPenawaran['id'],
                              dataPenawaran['no_penawaran'],
                              dataPenawaran['hal_penawaran'],
                              dataPenawaran['nama_customer'],
                              dataPenawaran['tanggal'],
                              dataPenawaran['signature_user']['nama_lengkap'],
                              dataPenawaran['signature_user']['tanda_tangan'],
                              company[0]['logo'],
                              company[0]['nama_company'],
                              company[0]['no_hp'],
                              company[0]['email'],
                              company[0]['provinsi'],
                              company[0]['kota'],
                              company[0]['alamat'],
                            );
                            // PenawaranPdf().printPdf(
                            //   dataPenawaran['id'],
                            //   dataPenawaran['no_penawaran'],
                            //   dataPenawaran['hal_penawaran'],
                            //   dataPenawaran['nama_customer'],
                            //   dataPenawaran['tanggal'],
                            //   dataPenawaran['signature_user']['nama_lengkap'],
                            //   dataPenawaran['signature_user']['tanda_tangan'],
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
                        child: const Text('Generate Penawaran',
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
                        return DataPenawaranWidget().data(
                          dataPenawaran['no_penawaran'],
                          dataPenawaran['hal_penawaran'],
                          dataPenawaran['nama_customer'],
                          dataPenawaran['tanggal'],
                          dataPenawaran['signature_user']['nama_lengkap'],
                        );
                      },
                    ),
                    productMain.isEmpty && productAdditional.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text(
                                "Data Produk Penawaran\nMasih Kosong Silahkan\nTambah Produk.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    productMain.isEmpty
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Main Product : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productMain.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IgnorePointer(
                            ignoring: productMain.isEmpty ? true : false,
                            child: Dismissible(
                              movementDuration: Duration.zero,
                              key: Key(productMain[index]['id'].toString()),
                              // key: Key("1"),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Hapus Produk Penawaran'),
                                      content: Text(
                                          'Apakah Anda ingin menghapus ${productMain[index]['produk_item']} | ${productMain[index]['tipe_item']}?'),
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
                              onDismissed: (direction) {
                                deleteTransportation(
                                  productMain[index]['id'],
                                );
                                setState(() {
                                  productMain.removeAt(index);
                                });
                                getProductPenawaran(widget.idPenawaran);
                              },
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
                                                        width: 170,
                                                        // color: Colors
                                                        //     .amber,
                                                        child: Text(
                                                          '${productMain[index]['produk_item']} | ${productMain[index]['tipe_item']}'
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
                                                            Get.to(
                                                              AddProductQuotation(
                                                                idPenawaran: widget
                                                                    .idPenawaran,
                                                                edit: true,
                                                                typeProduct:
                                                                    "main",
                                                                indexProduct:
                                                                    index,
                                                                idProduct:
                                                                    productMain[
                                                                            index]
                                                                        ['id'],
                                                              ),
                                                            );
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
                                                    "Kemasan",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${productMain[index]['kemasan']} | ${productMain[index]['tipe_kemasan']}',
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
                                                    "Mesin",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${productMain[index]['mesin']} | ${productMain[index]['tipe_mesin']}',
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
                                                    "Rp ${currencyFormatter.format(double.parse(productMain[index]['harga']))}",
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
                    const SizedBox(height: 10),
                    productAdditional.isEmpty
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Additional Product : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
                        itemCount: productAdditional.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IgnorePointer(
                            ignoring: false,
                            child: Dismissible(
                              movementDuration: Duration.zero,
                              key: Key(
                                  productAdditional[index]['id'].toString()),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Hapus Produk Penawaran'),
                                      content: Text(
                                          'Apakah Anda ingin Menghapus ${productAdditional[index]['produk_item']} | ${productAdditional[index]['tipe_item']} ?'),
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
                              onDismissed: (direction) {
                                deleteTransportation(
                                    productAdditional[index]['id']);
                                setState(() {
                                  productAdditional.removeAt(index);
                                });
                                getProductPenawaran(widget.idPenawaran);
                              },
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
                                                        width: 170,
                                                        // color: Colors
                                                        //     .amber,
                                                        child: Text(
                                                          '${productAdditional[index]['produk_item']} | ${productAdditional[index]['tipe_item']}'
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
                                                            Get.to(
                                                              AddProductQuotation(
                                                                idPenawaran: widget
                                                                    .idPenawaran,
                                                                edit: true,
                                                                typeProduct:
                                                                    "additional",
                                                                indexProduct:
                                                                    index,
                                                                idProduct:
                                                                    productAdditional[
                                                                            index]
                                                                        ['id'],
                                                              ),
                                                            );
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
                                                    "Kemasan",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${productAdditional[index]['kemasan']} | ${productAdditional[index]['tipe_kemasan']}',
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
                                                    "Mesin",
                                                    style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${productAdditional[index]['mesin']} | ${productAdditional[index]['tipe_mesin']}',
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
                                                    "Rp ${currencyFormatter.format(double.parse(productAdditional[index]['harga']))}",
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

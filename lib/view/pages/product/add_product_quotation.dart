import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:md3_auto_care/controllers/productController.dart';
import 'package:md3_auto_care/formatter/thousandsSeparatorInputFormatter.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';
import 'package:http/http.dart' as http;

class AddProductQuotation extends StatefulWidget {
  var idPenawaran;
  bool edit;
  String typeProduct;
  int indexProduct, idProduct;
  AddProductQuotation({
    super.key,
    required this.idPenawaran,
    required this.edit,
    required this.typeProduct,
    required this.indexProduct,
    required this.idProduct,
  });

  @override
  State<AddProductQuotation> createState() => _AddProductQuotationState();
}

class _AddProductQuotationState extends State<AddProductQuotation> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: '', decimalDigits: 0);

  // editing controller
  var produkItem = TextEditingController(text: '');
  var tipeItem = TextEditingController(text: '');
  var kemasan = TextEditingController(text: '');
  var tipeKemasan = TextEditingController(text: '');
  var mesin = TextEditingController(text: '');
  var tipeMesin = TextEditingController(text: '');
  var harga = TextEditingController(text: '');
  String? valueTypeProduct;

  var isLoadingAdd = false;

  @override
  void initState() {
    super.initState();
    if (widget.typeProduct != "null") {
      if (widget.typeProduct == "main") {
        getProductPenawaran(widget.idPenawaran, widget.typeProduct);
      } else {
        getProductPenawaran(widget.idPenawaran, widget.typeProduct);
      }
    }
  }

  List listTypeProduct = [
    'main',
    'additional',
  ];

  // Get Data product Penawaran
  int subTotalRp = 0;
  var isLoading2 = false;
  late Map<String, dynamic> dataProduct = {};
  late Map<String, dynamic> dataProductPenawaran = {};
  List<dynamic> productType = [];
  void getProductPenawaran(int idPenawaran, String typeProduct) async {
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
        dataProductPenawaran = dataProduct['product_penawaran'];
        productType = dataProductPenawaran['$typeProduct'];

        // Set data Edit Produk
        produkItem.text = productType[widget.indexProduct]['produk_item'];
        tipeItem.text = productType[widget.indexProduct]['tipe_item'];
        kemasan.text = productType[widget.indexProduct]['kemasan'];
        tipeKemasan.text = productType[widget.indexProduct]['tipe_kemasan'];
        mesin.text = productType[widget.indexProduct]['mesin'];
        tipeMesin.text = productType[widget.indexProduct]['tipe_mesin'];
        harga.text = currencyFormatter
            .format(double.parse(productType[widget.indexProduct]['harga']))
            .replaceAll('.', ',');
        valueTypeProduct = widget.typeProduct;

        print(productType);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.edit == true ? "Edit Produk Penawaran" : "Produk Penawaran",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: isLoading2
          ? Center(
              child: Container(
                width: 60,
                height: 60,
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: ListView(
                children: [
                  const Text(
                    "Produk Item",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh. Carbon Cleaner',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: produkItem,
                    ),
                  ),

                  // Type Item
                  const SizedBox(height: 15),
                  const Text(
                    "Tipe Item",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh. CC - 250 ',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: tipeItem,
                    ),
                  ),

                  // Lama penggunaan & jumlah
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 80,
                    // color: Colors.amber,
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        // Lama Penggunaan
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Kemasan",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  style:
                                      const TextStyle(color: Color(0xFF616161)),
                                  cursorColor: const Color(0xFF737373),
                                  decoration: const InputDecoration(
                                    hintText: 'Contoh. Botol',
                                    suffixStyle:
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
                                  controller: kemasan,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Jumlah Unit
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tipe Kemasan",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  style:
                                      const TextStyle(color: Color(0xFF616161)),
                                  cursorColor: const Color(0xFF737373),
                                  decoration: const InputDecoration(
                                    hintText: 'Contoh. 250 ml',
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
                                  controller: tipeKemasan,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lama penggunaan & jumlah
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 80,
                    // color: Colors.amber,
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        // Tanggal Digunakan
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Mesin",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) {
                                    mesin.value = mesin.value.copyWith(
                                      text: value.toUpperCase(),
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: value.length),
                                      ),
                                    );
                                  },
                                  style:
                                      const TextStyle(color: Color(0xFF616161)),
                                  cursorColor: const Color(0xFF737373),
                                  decoration: const InputDecoration(
                                    hintText: 'Contoh. DIESEL',
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
                                  controller: mesin,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Harga
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tipe",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) {
                                    tipeMesin.value = tipeMesin.value.copyWith(
                                      text: value.toUpperCase(),
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: value.length),
                                      ),
                                    );
                                  },
                                  style:
                                      const TextStyle(color: Color(0xFF616161)),
                                  cursorColor: Color(0xFF737373),
                                  decoration: const InputDecoration(
                                    hintText: 'Contoh. BENSIN',
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
                                  controller: tipeMesin,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tujuan Kendaraan
                  const SizedBox(height: 8),
                  const Text(
                    "Harga Per PCS",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                        hintText: '30,000',
                        prefixText: "Rp. ",
                        prefixStyle: TextStyle(color: Color(0xFF515151)),
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: harga,
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    "Type Product",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 53,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: valueTypeProduct,
                      hint: const Text(
                        "Pilih metode pembayaran",
                        style:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 12),
                      ),
                      onChanged: ((value) {
                        if (mounted) {
                          setState(() {
                            valueTypeProduct = value as String;
                            print(valueTypeProduct);
                          });
                        }
                      }),
                      items: listTypeProduct.map((item) {
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

                  // Button
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (mounted) {
                          setState(() {
                            isLoadingAdd = true;
                          });
                        }
                        // cek internet connection
                        final connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          print("NO INTERNET");
                        } else {
                          if (valueTypeProduct == null) {
                            SnackbarWidget()
                                .snackbarDanger("Type Produk harus di isi");
                          } else {
                            if (widget.edit != true) {
                              ProductController().postProduct(
                                produkItem.text,
                                tipeItem.text,
                                kemasan.text,
                                tipeKemasan.text,
                                mesin.text,
                                tipeMesin.text,
                                '${harga.text.replaceAll(RegExp('[^A-Za-z0-9]'), '')}',
                                widget.idPenawaran,
                                valueTypeProduct!,
                              );
                            } else {
                              ProductController().updateProduct(
                                widget.idProduct,
                                produkItem.text,
                                tipeItem.text,
                                kemasan.text,
                                tipeKemasan.text,
                                mesin.text,
                                tipeMesin.text,
                                '${harga.text.replaceAll(RegExp('[^A-Za-z0-9]'), '')}',
                                widget.idPenawaran,
                                valueTypeProduct!,
                              );
                            }
                          }
                        }
                        if (mounted) {
                          setState(() {
                            isLoadingAdd = false;
                          });
                        }
                      },
                      child: Text(
                        isLoadingAdd
                            ? 'Loading...'
                            : widget.edit == true
                                ? 'Edit Produk'
                                : 'Tambah Produk',
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
                ],
              ),
            ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
}

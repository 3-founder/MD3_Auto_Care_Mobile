import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:md3_auto_care/controllers/product_invoice_only_controller.dart';
import 'package:md3_auto_care/formatter/thousandsSeparatorInputFormatter.dart';
import 'package:md3_auto_care/widget/snackbarWidget.dart';

class AddProductInvoiceOnly extends StatefulWidget {
  String idProductInvoiceOnly;
  AddProductInvoiceOnly({super.key, required this.idProductInvoiceOnly});

  @override
  State<AddProductInvoiceOnly> createState() => _AddProductInvoiceOnlyState();
}

class _AddProductInvoiceOnlyState extends State<AddProductInvoiceOnly> {
// editing controller
  var deskripsiBarang = TextEditingController(text: '');
  var qty = TextEditingController(text: '0');
  var harga = TextEditingController(text: '0');
  String total = "0";

  var isLoadingAdd = false;

  int charLength = 0;

  final currencyFormatter = NumberFormat.currency(
    locale: 'ID',
    symbol: '',
    decimalDigits: 0,
  );

  _countQty(String value) {
    if (mounted) {
      setState(() {
        if (value == "") {
          value = "0";
        }
        var hrg = harga.text.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        int tl = int.parse(value) * int.parse(hrg);
        total = tl.toString();
        // total = value * int.parse(hrg);
      });
    }
  }

  _countHarga(String value) {
    if (mounted) {
      setState(() {
        if (value == "") {
          value = "0";
        }
        var hrg = value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        int tl = int.parse(qty.text) * int.parse(hrg);
        total = tl.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Produk Invoice",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ListView(
          children: [
            const Text(
              "Deskripsi Barang",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: (value) {
                  deskripsiBarang.value = deskripsiBarang.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: value.length),
                    ),
                  );
                },
                style: const TextStyle(color: Color(0xFF616161)),
                cursorColor: const Color(0xFF737373),
                decoration: const InputDecoration(
                  hintText: 'Contoh. MD3 CARBURETOR CLEANER',
                  hintStyle: TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF515151)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                  ),
                ),
                autocorrect: false,
                maxLines: 1,
                controller: deskripsiBarang,
              ),
            ),

            // Qty dan kemasan
            const SizedBox(height: 10),
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
                          "Qty",
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
                              hintText: 'Contoh. 45',
                              suffixStyle: TextStyle(color: Color(0xFF515151)),
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
                            controller: qty,
                            // keyboardType: TextInputType.number,
                            onChanged: _countQty,
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
                          "Harga",
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
                            cursorColor: Color(0xFF737373),
                            decoration: const InputDecoration(
                              hintText: '25.000',
                              prefixText: "Rp. ",
                              prefixStyle: TextStyle(color: Color(0xFF515151)),
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
                            controller: harga,
                            onChanged: _countHarga,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Total
            const SizedBox(height: 8),
            const Text(
              "Total",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFE4E4E4),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "Rp. ",
                      style: TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                    ),
                    Text(
                      // qty.text == "" ? "0" :
                      "${currencyFormatter.format(double.parse(total))}",
                      style: const TextStyle(
                          color: Color(0xFF8F8F8F), fontSize: 13),
                    )
                  ],
                ),
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
                    ProductInvoiceOnlyController().postProductInvoiceOnly(
                      deskripsiBarang.text,
                      qty.text,
                      harga.text.replaceAll(RegExp('[^A-Za-z0-9]'), ''),
                      total.replaceAll(RegExp('[^A-Za-z0-9]'), ''),
                      widget.idProductInvoiceOnly,
                    );
                    // ProductController().postProduct(
                    //   produkItem.text,
                    //   tipeItem.text,
                    //   kemasan.text,
                    //   tipeKemasan.text,
                    //   mesin.text,
                    //   tipeMesin.text,
                    //   '${harga.text.replaceAll(RegExp('[^A-Za-z0-9]'), '')}',
                    //   widget.idPenawaran,
                    //   valueTypeProduct!,
                    // );
                  }
                  if (mounted) {
                    setState(() {
                      isLoadingAdd = false;
                    });
                  }
                },
                child: Text(
                  isLoadingAdd ? 'Loading...' : 'Tambah Product',
                  style: TextStyle(fontSize: 12),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(1),
                  overlayColor: MaterialStateProperty.all(Color(0xFF3EA8D6)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5DC3EF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

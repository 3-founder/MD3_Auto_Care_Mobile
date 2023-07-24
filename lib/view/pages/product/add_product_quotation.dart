import 'package:flutter/material.dart';
import 'package:md3_auto_care/formatter/thousandsSeparatorInputFormatter.dart';

class AddProductQuotation extends StatefulWidget {
  const AddProductQuotation({super.key});

  @override
  State<AddProductQuotation> createState() => _AddProductQuotationState();
}

class _AddProductQuotationState extends State<AddProductQuotation> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // editing controller
  var produkItem = TextEditingController(text: '');
  var tipeItem = TextEditingController(text: '');
  var kemasan = TextEditingController(text: '');
  var tipeKemasan = TextEditingController(text: '');
  var mesin = TextEditingController(text: '');
  var tipeMesin = TextEditingController(text: '');
  var harga = TextEditingController(text: '');

  var isLoadingAdd = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Produk Penawaran",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: Padding(
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
                cursorColor: Color(0xFF737373),
                decoration: const InputDecoration(
                  hintText: 'Contoh. Carbon Cleaner',
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
                            style: const TextStyle(color: Color(0xFF616161)),
                            cursorColor: const Color(0xFF737373),
                            decoration: const InputDecoration(
                              hintText: 'Contoh. Botol',
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
                            style: const TextStyle(color: Color(0xFF616161)),
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
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (value) {
                              mesin.value = mesin.value.copyWith(
                                text: value.toUpperCase(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: value.length),
                                ),
                              );
                            },
                            style: const TextStyle(color: Color(0xFF616161)),
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
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (value) {
                              tipeMesin.value = tipeMesin.value.copyWith(
                                text: value.toUpperCase(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: value.length),
                                ),
                              );
                            },
                            style: const TextStyle(color: Color(0xFF616161)),
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
                cursorColor: Color(0xFF737373),
                decoration: const InputDecoration(
                  hintText: '2,000,000',
                  prefixText: "Rp. ",
                  prefixStyle: TextStyle(color: Color(0xFF515151)),
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
                controller: harga,
              ),
            ),

            // Button
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  // if (mounted) {
                  //   setState(() {
                  //     isLoadingAdd = true;
                  //   });
                  // }
                  // // cek internet connection
                  // final connectivityResult =
                  //     await (Connectivity().checkConnectivity());
                  // if (connectivityResult == ConnectivityResult.none) {
                  //   print("NO INTERNET");
                  // } else {
                  //   TransportationController().postTransportation(
                  //     widget.id_customer,
                  //     tipeKendaraan.text,
                  //     "${lama_penggunaan.text} jam",
                  //     jumlah_unit.text,
                  //     "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                  //     '${hargaC.text.replaceAll(RegExp('[^A-Za-z0-9]'), '')}',
                  //     tujuan_kendaraan.text,
                  //   );
                  // }
                  // if (mounted) {
                  //   setState(() {
                  //     isLoadingAdd = false;
                  //   });
                  // }
                },
                child: Text(
                  isLoadingAdd ? 'Loading...' : 'Tambah Transportasi',
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

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
}

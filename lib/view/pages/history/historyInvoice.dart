import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:md3_auto_care/view/pages/invoice/data_invoiceOnly.dart';

class HistoryInvoice extends StatefulWidget {
  const HistoryInvoice({super.key});

  @override
  State<HistoryInvoice> createState() => _HistoryInvoiceState();
}

class _HistoryInvoiceState extends State<HistoryInvoice> {
  bool _isPopupVisible = false;

  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateTime2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var search = TextEditingController(text: '');

  bool filter = false;
  String? startDate, endDate;

  @override
  void initState() {
    super.initState();
    getInvoice();
  }

  // get data penawaran from api
  var isLoading = false;
  List<dynamic> dataInvoice = [];
  List<dynamic> filteredList = [];
  void getInvoice() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    String url = "$baseUrl/invoice-only";
    String urlFilter =
        "$baseUrl/filter/invoice-only?start_date=$startDate&end_date=$endDate";

    try {
      http.Response response = await http.get(
          Uri.parse(filter ? urlFilter : url),
          headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataInvoice = json.decode(response.body)['data'];
        filteredList = dataInvoice;
        // print('Cek data Invoice : $dataInvoice');
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

  // Filter Data
  void _filterData(String query) {
    if (mounted) {
      setState(() {
        filteredList = dataInvoice
                .where((item) =>
                    item['yth'].toLowerCase().contains(query.toLowerCase()))
                .toList()
                .isEmpty
            ? filteredList = dataInvoice
                .where((item) =>
                    item['sales'].toLowerCase().contains(query.toLowerCase()))
                .toList()
            : filteredList = dataInvoice
                .where((item) =>
                    item['yth'].toLowerCase().contains(query.toLowerCase()))
                .toList();
        // print(filteredList);
      });
    }
  }

  // Filter
  void _togglePopupVisibility() {
    if (mounted) {
      setState(() {
        _isPopupVisible = !_isPopupVisible;
      });
    }
    if (_isPopupVisible) {
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
                                    "Filter",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _togglePopupVisibility();
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
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tanggal awal
                            const Text(
                              "Tanggal awal",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () async {
                                final date = await pickerDate();
                                if (date == null) return;
                                if (mounted) {
                                  setState(() {
                                    final newDateTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                    );
                                    dateTime = date;
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFB4B4B4),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                        style: const TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Tanggal Akhir
                            const SizedBox(height: 20),
                            const Text(
                              "Tanggal Akhir",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () async {
                                final date2 = await pickerDate2();
                                if (date2 == null) return;
                                if (mounted) {
                                  setState(() {
                                    final newDateTime2 = DateTime(
                                      date2.year,
                                      date2.month,
                                      date2.day,
                                    );
                                    dateTime2 = date2;
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFB4B4B4),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "${dateTime2.year}-${dateTime2.month}-${dateTime2.day}",
                                        style: const TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final connectivityResult =
                                      await (Connectivity()
                                          .checkConnectivity());
                                  if (connectivityResult ==
                                      ConnectivityResult.none) {
                                    print("NO INTERNET");
                                  } else {
                                    filter = true;
                                    startDate =
                                        '${dateTime.year}-${dateTime.month}-${dateTime.day}';
                                    endDate =
                                        '${dateTime2.year}-${dateTime2.month}-${dateTime2.day}';
                                    getInvoice();
                                    if (mounted) {
                                      setState(() {});
                                    }
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Cari'),
                                style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(1),
                                  overlayColor: MaterialStateProperty.all(
                                      const Color(0xFF3EA8D6)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF5DC3EF)),
                                ),
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
      appBar: AppBar(
        title: const Text(
          "History Invoice",
          style: TextStyle(fontSize: 18),
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextField(
                            onChanged: _filterData,
                            style: const TextStyle(color: Color(0xFF616161)),
                            cursorColor: const Color(0xFF737373),
                            decoration: const InputDecoration(
                              prefixStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              hintText:
                                  'Berdasarkan nama customer atau perusahaan',
                              labelText: "Cari Customer",
                              labelStyle: TextStyle(fontSize: 13),
                              suffixIcon: Icon(Icons.search),
                              hintStyle: TextStyle(
                                  color: Color(0xFF8F8F8F), fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF5DC3EF)),
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
                            controller: search,
                            textInputAction: TextInputAction.search,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.blueAccent,
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  _togglePopupVisibility();
                                });
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.filter_alt_outlined,
                                    size: 21,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    children: [
                                      Text(""),
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                      Text(
                                        "Filter",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "History List",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // server != null
                  //     ? const Column(
                  //         children: [
                  //           SizedBox(height: 100),
                  //           Text(
                  //             "Server Mati",
                  //             style: TextStyle(
                  //               fontSize: 15,
                  //               color: Colors.red,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     :
                  dataInvoice.isEmpty
                      ? const Column(
                          children: [
                            SizedBox(height: 100),
                            Text(
                              "Data masih kosong!\nSilahkan buat Quotation\nTerlebih dahulu.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF626262),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : filteredList.isEmpty
                          ? const Column(
                              children: [
                                SizedBox(height: 100),
                                Text(
                                  "Data yang anda cari kosong!\nCoba cari dengan kata\nkunci yang lain.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF626262),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: filteredList.length,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final item = filteredList[index];
                                return InkWell(
                                  splashColor: const Color(0xFF7EECFF),
                                  onTap: () async {
                                    // ceck Interner Connection
                                    final connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());
                                    if (connectivityResult ==
                                        ConnectivityResult.none) {
                                      debugPrint("NO INTERNET");
                                    } else {
                                      // to Data Invoice
                                      Get.to(
                                        DataInvoiceOnly(
                                          idInvoice: item['id'],
                                        ),
                                      );
                                      search.text = '';
                                      getInvoice();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFA3E2FD),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(7),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFDBDBDB),
                                                blurRadius: 2,
                                                offset: Offset(
                                                    1, 2), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item['yth'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF353535),
                                                      ),
                                                    ),
                                                    Text(
                                                      item['tanggal'],
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Sales",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF353535),
                                                      ),
                                                    ),
                                                    Text(
                                                      item['sales'],
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2),
                                                Container(
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Tanda Tangan",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                      ),
                                                    ),
                                                    Text(
                                                      item['signature_user']
                                                          ['nama_lengkap'],
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(const Duration(days: 29)),
        lastDate: DateTime.now(),
      );
  Future<DateTime?> pickerDate2() => showDatePicker(
        context: context,
        initialDate: dateTime2,
        firstDate: dateTime,
        lastDate: DateTime.now(),
      );
}

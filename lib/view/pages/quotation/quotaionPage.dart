import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:md3_auto_care/view/pages/product/add_product_quotation.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({super.key});

  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  DateTime dtNow = DateTime.now();
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var nomorKutipanC = TextEditingController(text: '');
  var kutipanPenyewaanC = TextEditingController(text: '');
  var namaCustomerC = TextEditingController(text: '');
  var emailC = TextEditingController(text: '');
  var namaPerusahaanC = TextEditingController(text: '');
  var kotaC = TextEditingController(text: '');
  var alamatC = TextEditingController(text: '');
  var kodePosC = TextEditingController(text: '');
  var tanggalC = null;
  var noHpC = TextEditingController(text: '');
  var komentarC = TextEditingController(text: '');
  int? valueTtd;

  var isLoadingSimpan = false;

  List<String> ttd_user = [
    "M.Fadil Adim",
  ];

  @override
  void initState() {
    super.initState();
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Buat Penawaran",
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
                children: [
                  // Nomor Kutipan
                  const Text(
                    "No Penawaran",
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
                        hintText: 'Contoh. 02 / V / 23 / PNWR / MTAF / TS',
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
                      controller: nomorKutipanC,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                      ],
                    ),
                  ),

                  // Kutipan
                  const SizedBox(height: 15),
                  const Text(
                    "Hal",
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
                        hintText: 'Contoh. Penawaran Harga Surabaya',
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
                      controller: kutipanPenyewaanC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Nama Customer
                  const SizedBox(height: 15),
                  const Text(
                    "Nama Customer",
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
                        hintText: 'Contoh. Bu Shinta',
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
                      controller: namaCustomerC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Kode pos dan tanggal
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tanggal",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
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
                            setState(() {
                              dateTime = date;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFE4E4E4),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
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
                                        color: Color(0xFF515151), fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tanda tangan
                  const SizedBox(height: 15),
                  const Text(
                    "Tanda tangan",
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
                      value: valueTtd,
                      hint: const Text(
                        "Pilih yang bertanda tangan",
                        style:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 12),
                      ),
                      onChanged: ((value) {
                        setState(() {
                          valueTtd = value as int;
                        });
                      }),
                      items: ttd_user.map((item) {
                        return DropdownMenuItem(
                          child: Text(
                            item,
                            style: const TextStyle(
                                color: Color(0xFF8F8F8F), fontSize: 13),
                          ),
                          value: item,
                        );
                      }).toList(),
                    ),
                  ),

                  // Buttom
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.to(AddProductQuotation());
                        // if (mounted) {
                        //   setState(() {
                        //     isLoadingSimpan = true;
                        //   });
                        // }
                        // final connectivityResult =
                        //     await (Connectivity().checkConnectivity());
                        // if (connectivityResult == ConnectivityResult.none) {
                        //   print("NO INTERNET");
                        // } else {
                        //   // Get.to(DataTransportationPage(id_customer: 4));
                        //   if (valueTtd != null) {
                        //     QuotationController().postQuotation(
                        //       kutipanPenyewaanC.text,
                        //       namaCustomerC.text,
                        //       emailC.text,
                        //       namaPerusahaanC.text,
                        //       kotaC.text,
                        //       alamatC.text,
                        //       kodePosC.text,
                        //       '${dateTime.year}-${dateTime.month}-${dateTime.day}',
                        //       nomorKutipanC.text,
                        //       '${noHpC.text}',
                        //       komentarC.text,
                        //       '',
                        //       valueTtd!,
                        //     );
                        //   } else {
                        //     SnackbarWidget()
                        //         .snackbarError("Tanda tangan Wajib di pilih");
                        //   }
                        // }
                        // if (mounted) {
                        //   setState(() {
                        //     isLoadingSimpan = false;
                        //   });
                        // }
                      },
                      child: Text(isLoadingSimpan ? 'Loading...' : 'Simpan'),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(1),
                        overlayColor: MaterialStateProperty.all(Colors.green),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF3FC633)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
}

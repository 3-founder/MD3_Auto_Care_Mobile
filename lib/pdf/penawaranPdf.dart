import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:md3_auto_care/controllers/quotationController.dart';
import 'package:md3_auto_care/pdf/widget_table_penawaran.dart';
import 'package:md3_auto_care/pdf/widget_text_pdf_penawaran.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/utils/convertOriginalDate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

class PenawaranPdf {
  void printPdf(
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
    bool generate,
  ) async {
    final pdf = pw.Document();
    String originalDateInvoice = ConvertOriginalDate().dateFormat(tanggal);
    final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

    //format phone Company
    String? formattedPhoneCompany;
    if (noHpCompany.contains('[') && noHpCompany.contains(']')) {
      formattedPhoneCompany =
          noHpCompany.replaceRange(5, 5, ' ').replaceRange(9, 9, ' ');
    } else {
      formattedPhoneCompany = noHpCompany.replaceAllMapped(
          RegExp(r".{4}"), (match) => "${match.group(0)} ");
    }

    // get ttd Image
    // final url = '$urlWeb/public/storage/$exportedImage';
    final urlTtd = '$urlWeb/storage/ttd/$ttd';
    final response = await http.get(Uri.parse(urlTtd));
    final bytes_ttd = response.bodyBytes;

    // get logo company
    final urlCompany = '$urlWeb/storage/$logoCompany';
    final responseCompany = await http.get(Uri.parse(urlCompany));
    final bytesCompany = responseCompany.bodyBytes;

    late Map<String, dynamic> dataPenawaran = {};
    Map<String, dynamic> product = {};
    List<dynamic> productMain = [];
    List<dynamic> productAdditional = [];
    dataPenawaran =
        (await QuotationController().getProductPenawaran(idPenawaran))!;
    product = dataPenawaran['product_penawaran'];
    productMain = product['main'];
    productAdditional = product['additional'];
    print(productAdditional);
    // var listProduct = List<dynamic>.from(product);
    // var dataMain = List<dynamic>.from(product[0]['main']);

    final header = pw.Container(
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                    width: 65,
                    height: 65,
                    child: pw.Image(
                      pw.MemoryImage(
                        (await rootBundle.load('assets/logo/logo_mta.png'))
                            .buffer
                            .asUint8List(),
                      ),
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        namaCompany,
                        style: const pw.TextStyle(
                          fontSize: 14.5,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "EXCLUSIVE PRODUCT WITH SMART MAINTANANCE",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Container(
                    width: 65,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "No",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "Hal",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "Kpd Yth",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(""),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        ": $noPenawaran",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        ": $halPenawaran",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        ": $namaCustomer",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        "  Ditempat.",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 80,
                height: 80,
                child: pw.Image(
                  pw.MemoryImage(bytesCompany),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                "$kota, $originalDateInvoice",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final tableDataMain = pw.ListView.builder(
      itemCount: productMain.length,
      itemBuilder: (context, index) {
        return pw.Table(
          border: pw.TableBorder.all(width: 1),
          columnWidths: {
            0: pw.FlexColumnWidth(0.3),
            1: pw.FlexColumnWidth(2),
            2: pw.FlexColumnWidth(1),
            3: pw.FlexColumnWidth(1),
            4: pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(children: [
              pw.Container(
                width: double.infinity,
                height: 28,
                child: pw.Center(
                  child: pw.Text(
                    '${index + 1}',
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['produk_item'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['tipe_item'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['kemasan'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['tipe_kemasan'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['mesin'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productMain[index]['tipe_mesin'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Container(
                width: double.infinity,
                height: 28,
                child: pw.Center(
                  child: pw.Text(
                    "Rp ${currencyFormatter.format(double.parse(productMain[index]['harga']))}",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        );
      },
    );

    final tableDataAdditional = pw.ListView.builder(
      itemCount: productAdditional.length,
      itemBuilder: (context, index) {
        return pw.Table(
          border: pw.TableBorder.all(width: 1),
          columnWidths: {
            0: pw.FlexColumnWidth(0.3),
            1: pw.FlexColumnWidth(2),
            2: pw.FlexColumnWidth(1),
            3: pw.FlexColumnWidth(1),
            4: pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(children: [
              pw.Container(
                width: double.infinity,
                height: 28,
                child: pw.Center(
                  child: pw.Text(
                    '${(index + 1) + productMain.length}',
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['produk_item'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['tipe_mesin'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['kemasan'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['tipe_kemasan'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // pw.Container(
              //   width: double.infinity,
              //   height: 28,
              //   child: pw.Center(
              //     child: pw.Text(
              //       'DIESEL',
              //       style: pw.TextStyle(
              //         color: PdfColors.black,
              //         fontSize: 10,
              //         fontWeight: pw.FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['mesin'],
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Center(
                            child: pw.Text(
                              productAdditional[index]['tipe_mesin'],
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Container(
                width: double.infinity,
                height: 28,
                child: pw.Center(
                  child: pw.Text(
                    "Rp ${currencyFormatter.format(double.parse(productAdditional[index]['harga']))}",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        );
      },
    );

    // Catatan
    final catatan = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        WidgetTextPdfPenawaran().titleCatatan,
        pw.Padding(
          padding: pw.EdgeInsets.only(right: 30, top: 20),
          child: pw.Column(
            children: [
              pw.SizedBox(height: 2),
              pw.Text(
                "Hormat Kami",
                style: const pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Container(
                width: 50,
                height: 35,
                child: pw.Image(
                  pw.MemoryImage(bytes_ttd),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                namaTtd,
                style: const pw.TextStyle(
                  fontSize: 10,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                "Direktur",
                style: const pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final address = pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Address:",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                pw.Container(
                  width: 275,
                  child: pw.Text(
                    "$alamat,",
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                ),
                // pw.Text(
                //   "Ruko Festive Garden Blok AA 16 No 88, Grand Wisata,",
                //   style: pw.TextStyle(
                //     fontStyle: pw.FontStyle.italic,
                //     fontSize: 11,
                //   ),
                // ),
                // pw.Text(
                //   "Kel. Lambang Sari, Kec. Tambun Sel, ",
                //   style: pw.TextStyle(
                //     fontStyle: pw.FontStyle.italic,
                //     fontSize: 11,
                //   ),
                // ),
                pw.Text(
                  "$kota, $provinsi",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            pw.SizedBox(width: 15),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(children: [
                  pw.Text(
                    "Phone : ",
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    formattedPhoneCompany,
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Text(
                    "Email : ",
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    emailCompany,
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                ]),
              ],
            ),
            pw.SizedBox(width: 8),
            pw.Container(
              width: 60,
              height: 60,
              child: pw.Image(
                pw.MemoryImage(
                  (await rootBundle
                          .load('assets/logo/logo_footer_penawaran.png'))
                      .buffer
                      .asUint8List(),
                ),
              ),
            ),
          ],
        ),
        // pw.SizedBox(height: 5),
        pw.Container(
          width: double.infinity,
          height: 10,
          color: PdfColors.red,
        ),
      ],
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        header: (context) {
          return header;
        },
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              WidgetTextPdfPenawaran().titleHormat,
              pw.SizedBox(height: 15),
              WidgetTablePenawaran().tableHeader,
              WidgetTablePenawaran().tableMain,
              tableDataMain,
              WidgetTablePenawaran().tableAdditional,
              tableDataAdditional,
              catatan,
              // address,
            ],
          ),
        ],
        footer: (context) {
          return address;
        },
      ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath1 = '${output.path}/penawaran.pdf';
    final file = File(filePath1);
    await file.writeAsBytes(await pdf.save());

    if (generate == false) {
      String pdfFilePath = await filePath1;
      sharePDF(pdfFilePath);
    } else {
      await OpenFile.open(file.path);
    }
    // await OpenFile.open(file.path);
    print('PDF saved to ${file.path}');
  }

  void sharePDF(String filePath) {
    Share.shareFiles([filePath], text: 'Sharing PDF');
  }
}

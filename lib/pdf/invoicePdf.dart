import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:md3_auto_care/pdf/widget_table_invoice.dart';
import 'package:md3_auto_care/utils/base_url.dart';
import 'package:md3_auto_care/utils/convertOriginalDate.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class InvoicePdf {
  void printPdf(
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
  ) async {
    final pdf = pw.Document();
    String formatDateInvoice = ConvertOriginalDate().dateFormatInvoice(tanggal);
    String formatDateInvoiceTempo =
        ConvertOriginalDate().dateFormatInvoice(tanggalJatuhTempo);

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
    final urlTtd = '$urlWeb/storage/ttd/$ttdDirektur';
    final response = await http.get(Uri.parse(urlTtd));
    final bytes_ttd = response.bodyBytes;

    // data table product invoice
    int subTotalData = 0;
    int grandTotal = 0;
    int sisaTagihan = 0;

    late Map<String, dynamic> dataProduct = {};
    List<dynamic> dataProductInvoice = [];
    String url = "$baseUrl/invoice-only-product/$idInvoice";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataProduct = json.decode(response.body)['data'];
        dataProductInvoice = dataProduct['invoice_only'];
        // print(dataProductInvoice);
        // print(product);
        // print(cekTrans);
        for (var i = 0; i < dataProductInvoice.length; i++) {
          subTotalData += int.parse(dataProductInvoice[i]['total']);
        }
        print("Sub Total = $subTotalData");
        grandTotal = (subTotalData + int.parse(ongkosKirim)) -
            (int.parse(diskon) + int.parse(cashback));
        sisaTagihan = grandTotal;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    final widgetInvoice = pw.Container(
      child: pw.Column(
        children: [
          pw.Text(
            "INVOICE",
            style: pw.TextStyle(
              fontSize: 17,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            children: [
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "Yth : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 8),
                    // pw.Text(
                    //   ":",
                    //   style: pw.TextStyle(
                    //       fontSize: 7,
                    //       color: PdfColors.black,
                    //       fontWeight: pw.FontWeight.bold),
                    // ),
                    pw.SizedBox(height: 9),
                    pw.Text(
                      "SALES : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      "TANGGAL : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "NO INVOICE : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "PO NO : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "TANGGAL JATUH TEMPO : ",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.Container(
                width: 100,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      yth,
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Container(
                      width: 100,
                      height: 0.2,
                      color: PdfColors.black,
                    ),
                    pw.SizedBox(height: 2.8),
                    pw.Text(
                      "Ditempat.",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Container(
                      width: 100,
                      height: 0.2,
                      color: PdfColors.black,
                    ),
                    pw.SizedBox(height: 8.8),
                    pw.Text(
                      sales,
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      formatDateInvoice,
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      noInvoice,
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      poNo == "null" ? "-" : poNo,
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      formatDateInvoice,
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final header = pw.Container(
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: 80,
                        height: 80,
                        child: pw.Image(
                          pw.MemoryImage(
                            (await rootBundle
                                    .load('assets/logo/md3_auto_care.png'))
                                .buffer
                                .asUint8List(),
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        "#LONGDRIVESWITHOUTPROBLEM",
                        style: const pw.TextStyle(
                          fontSize: 4,
                          color: PdfColors.red,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 30,
                            child: pw.Text(
                              "Phone",
                              style: const pw.TextStyle(
                                fontSize: 7,
                                color: PdfColors.black,
                              ),
                            ),
                          ),
                          pw.Text(
                            ": $formattedPhoneCompany",
                            style: const pw.TextStyle(
                              fontSize: 7,
                              color: PdfColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(width: 7),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        namaCompany,
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "EXCLUSIVE PRODUCT WITH SMART MAINTANANCE",
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        "Email : $emailCompany",
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 34,
                    child: pw.Text(
                      "Address  : ",
                      style: const pw.TextStyle(
                        fontSize: 7,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  pw.Text(
                    "$alamatCompany",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 2),
              pw.Row(
                children: [
                  pw.Container(
                    width: 34,
                  ),
                  pw.Text(
                    "$kotaCompany , $provinsiCompany",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          widgetInvoice,
        ],
      ),
    );

    final dataTable = pw.ListView.builder(
      itemCount: dataProductInvoice.length,
      itemBuilder: (context, index) {
        return pw.Table(
          // border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(0.3),
            1: pw.FlexColumnWidth(2),
            2: pw.FlexColumnWidth(0.5),
            3: pw.FlexColumnWidth(0.9),
            4: pw.FlexColumnWidth(1.2),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Center(
                      child: pw.Text(
                        "${index + 1}",
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Center(
                      child: pw.Text(
                        dataProductInvoice[index]['deskripsi_barang'],
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Center(
                      child: pw.Text(
                        dataProductInvoice[index]['qty'],
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Center(
                        child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text(
                          "Rp",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          "${currencyFormatter.format(double.parse(dataProductInvoice[index]['harga']))}",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 2, horizontal: 5),
                    child: pw.Center(
                        child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Rp",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          "${currencyFormatter.format(double.parse(dataProductInvoice[index]['total']))}",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    final subTotal = pw.Row(
      children: [
        pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                "SUBTOTAL",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "DISKON",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "ONGKOS KIRIM",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "CASHBACK",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "GRAND TOTAL",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "SISA TAGIHAN",
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
            ],
          ),
        ),
        pw.SizedBox(width: 15),
        pw.Container(
          width: 116,
          child: pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    "${currencyFormatter.format(double.parse(subTotalData.toString()))}",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    diskon == "0"
                        ? "-"
                        : currencyFormatter.format(double.parse(diskon)),
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    ongkosKirim == "0"
                        ? "-"
                        : currencyFormatter.format(double.parse(ongkosKirim)),
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    cashback == "0"
                        ? "-"
                        : currencyFormatter.format(double.parse(cashback)),
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    currencyFormatter
                        .format(double.parse(grandTotal.toString())),
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Rp",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    ketPembayaran == "lunas"
                        ? "-"
                        : currencyFormatter
                            .format(double.parse(sisaTagihan.toString())),
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
            ],
          ),
        )
      ],
    );

    final metodePembayaran = pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Metode Pembayaran",
                style: const pw.TextStyle(
                  fontSize: 7,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              mPembayaran == "cash"
                  ? pw.Text(
                      "Cash",
                      style: const pw.TextStyle(
                        fontSize: 7,
                        color: PdfColors.black,
                      ),
                    )
                  : pw.Text(
                      "Transfer Ke : ",
                      style: const pw.TextStyle(
                        fontSize: 7,
                        color: PdfColors.black,
                      ),
                    ),
              pw.SizedBox(height: 3),
              mPembayaran == "cash"
                  ? pw.Container(width: 100, height: 20)
                  : pw.Row(
                      children: [
                        pw.Container(
                          width: 70,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                "Atas Nama ",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                "No Rek ",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                "Bank ",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 100,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                ": $atasNamaBank",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                ": $noRekening",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                ": $namaBank",
                                style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Hormat Kami,",
                style: const pw.TextStyle(
                  fontSize: 7,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                child: pw.Container(
                  width: 40,
                  height: 25,
                  child: pw.Image(
                    pw.MemoryImage(bytes_ttd),
                  ),
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "M Taufik Atallah",
                style: const pw.TextStyle(
                  fontSize: 7,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                "Direktur",
                style: const pw.TextStyle(
                  fontSize: 7,
                  color: PdfColors.black,
                ),
              ),
            ],
          ),
          subTotal,
        ],
      ),
    );

    final imgBelumBayar = pw.MemoryImage(
      (await rootBundle.load('assets/image/bg_belum_lunas.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a5.landscape,
          margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          // header: (context) {
          //   return header;
          // },
          build: (pw.Context context) {
            return [
              pw.Container(
                width: double.infinity,
                decoration: ketPembayaran == "lunas"
                    ? null
                    : pw.BoxDecoration(
                        image: pw.DecorationImage(image: imgBelumBayar)),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    header,
                    pw.SizedBox(height: 7),
                    WidgetTableInvoice().lineTable,
                    WidgetTableInvoice().headerTable,
                    WidgetTableInvoice().lineTable,
                    dataTable,
                    WidgetTableInvoice().lineTable,
                    pw.SizedBox(height: 2),
                    metodePembayaran,
                  ],
                ),
              )
            ];
          }
          // footer: (context) {
          //   return address;
          // },
          ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath1 = '${output.path}/penawaran.pdf';
    final file = File(filePath1);
    await file.writeAsBytes(await pdf.save());
    // await OpenFile.open(file.path);

    if (generate == false) {
      String pdfFilePath = await filePath1;
      sharePDF(pdfFilePath);
    } else {
      await OpenFile.open(file.path);
    }
  }

  void sharePDF(String filePath) {
    Share.shareFiles([filePath], text: 'Sharing PDF');
  }
}

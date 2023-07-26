import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:md3_auto_care/pdf/widget_table_invoice.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicePdf {
  void printPdf() async {
    final pdf = pw.Document();

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
                      "JELITA MOTOR",
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
                      "Shinta",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      "21/06/2023",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "01/VI/23/JM/MD3",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "-",
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "21/07/2023",
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
                            ": 0813-1095-5281",
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
                        "PT MAKMUR TERUS ABADI",
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
                        "Email : mtabadi22@gmail.com",
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
                children: [
                  pw.Container(
                    width: 30,
                    child: pw.Text(
                      "Address",
                      style: const pw.TextStyle(
                        fontSize: 7,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  pw.Text(
                    ": Ruko Festive Garden Blok AA 16 No 88, Grand Wisata",
                    style: const pw.TextStyle(
                      fontSize: 7,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                children: [
                  pw.Container(
                    width: 34,
                  ),
                  pw.Text(
                    "Bekasi , Jawa Barat",
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
      itemCount: 4,
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
                        "MD3 CARBURETOR CLEANER",
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
                        "12",
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
                          "25.000",
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
                          "45.000",
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
                    "1.450.000",
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
                    "-",
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
                    "-",
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
                    "-",
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
                    "1.450.000",
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
                    "1.450.000",
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
              pw.Text(
                "Transfer Ke : ",
                style: const pw.TextStyle(
                  fontSize: 7,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Row(
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
                          ": M Taufan Athallah",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          ": 7285084077",
                          style: const pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          ": BCA",
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
                  color: PdfColors.grey,
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

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5.landscape,
        margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        // header: (context) {
        //   return header;
        // },
        build: (pw.Context context) => [
          pw.Column(
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
        ],
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
    await OpenFile.open(file.path);
  }

  void sharePDF(String filePath) {
    Share.shareFiles([filePath], text: 'Sharing PDF');
  }
}

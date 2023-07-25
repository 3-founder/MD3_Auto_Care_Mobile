import 'dart:io';

import 'package:flutter/services.dart';
import 'package:md3_auto_care/pdf/widget_table_penawaran.dart';
import 'package:md3_auto_care/pdf/widget_text_pdf_penawaran.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';

class PenawaranPdf {
  void printPdf() async {
    final pdf = pw.Document();

    // final ByteData imageMta = await rootBundle.load('assets/logo/logo_mta.png');
    // Uint8List imageDataMta = (imageMta).buffer.asUint8List();

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
                        "PT MAKMUR TERUS ABADI",
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
                        ": 02 / V / 23 / PNWR / MTAF / TS",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        ": Penawaran Harga Surabaya",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        ": Bu Shinta",
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
                  pw.MemoryImage(
                    (await rootBundle.load('assets/logo/md3_auto_care.png'))
                        .buffer
                        .asUint8List(),
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                "Bekasi, 16 Mei 2023",
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

    final tableDataMain = pw.Table(
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
                '1',
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
                          "Carbon Cleaner",
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
                          "CC - 250",
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
                          "Botol",
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
                          "250 ml",
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
                          "DIESEL",
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
                          "BENSIN",
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
                'Rp 26.000',
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

    final tableDataAdditional = pw.Table(
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
                '2',
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
                          "Carbon Cleaner",
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
                          "CC - 250",
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
                          "Botol",
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
                          "250 ml",
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
                          "DIESEL",
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
                          "BENSIN",
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
                'Rp 26.000',
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
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Container(
                width: 80,
                height: 50,
                color: PdfColors.amber,
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "M Taufan",
                style: const pw.TextStyle(
                  fontSize: 11,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                "Direktur",
                style: const pw.TextStyle(
                  fontSize: 11,
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
                pw.Text(
                  "Ruko Festive Garden Blok AA 16 No 88, Grand Wisata,",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    fontSize: 11,
                  ),
                ),
                pw.Text(
                  "Kel. Lambang Sari, Kec. Tambun Sel, ",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    fontSize: 11,
                  ),
                ),
                pw.Text(
                  "Bekasi, Jawa Barat",
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
                    "0813 - 1095 - 5281",
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
                    "mtabadi22@gmail.com",
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
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              header,
              WidgetTextPdfPenawaran().titleHormat,
              pw.SizedBox(height: 15),
              WidgetTablePenawaran().tableHeader,
              WidgetTablePenawaran().tableMain,
              tableDataMain,
              WidgetTablePenawaran().tableAdditional,
              tableDataAdditional,
              catatan,
              pw.SizedBox(height: 25),
              address,
            ],
          ),
        ],
      ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath1 = '${output.path}/penawaran.pdf';
    final file = File(filePath1);
    await file.writeAsBytes(await pdf.save());

    // if (generate == false) {
    //   String pdfFilePath = await filePath1;
    //   sharePDF(pdfFilePath);
    // } else {
    //   await OpenFile.open(file.path);
    // }
    await OpenFile.open(file.path);
    print('PDF saved to ${file.path}');
  }

  void sharePDF(String filePath) {
    Share.shareFiles([filePath], text: 'Sharing PDF');
  }
}

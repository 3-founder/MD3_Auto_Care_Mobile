import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WidgetTablePenawaran {
  final tableHeader = pw.Table(
    border: pw.TableBorder.all(width: 1),
    columnWidths: {
      0: pw.FlexColumnWidth(0.3),
      1: pw.FlexColumnWidth(2),
      2: pw.FlexColumnWidth(1),
      3: pw.FlexColumnWidth(1),
      4: pw.FlexColumnWidth(1),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: PdfColors.green,
            width: double.infinity,
            height: 30,
            child: pw.Center(
              child: pw.Text(
                'No',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Container(
            color: PdfColors.green,
            width: double.infinity,
            height: 30,
            child: pw.Center(
              child: pw.Text(
                'Item',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Container(
            color: PdfColors.green,
            width: double.infinity,
            height: 30,
            child: pw.Center(
              child: pw.Text(
                'Kemasan',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Container(
            color: PdfColors.green,
            width: double.infinity,
            height: 30,
            child: pw.Center(
              child: pw.Text(
                'Mesin',
                style: pw.TextStyle(
                  color: PdfColors.white,
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
                    color: PdfColors.green,
                    width: double.infinity,
                    height: 15,
                    child: pw.Center(
                      child: pw.Text(
                        'Harga',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Container(
                    color: PdfColors.green,
                    width: double.infinity,
                    height: 15,
                    child: pw.Center(
                      child: pw.Text(
                        'Per Pcs',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ],
  );

  final tableMain = pw.Table(
    border: pw.TableBorder.all(width: 0),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: PdfColors.green,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Center(
                child: pw.Text(
                  "Main Product",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.white,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  final tableAdditional = pw.Table(
    border: pw.TableBorder.all(width: 0),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: PdfColors.green,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Center(
                child: pw.Text(
                  "Additional Product",
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.white,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

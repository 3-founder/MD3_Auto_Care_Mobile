import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WidgetTableInvoice {
  final headerTable = pw.Table(
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
              padding: const pw.EdgeInsets.all(4),
              child: pw.Center(
                child: pw.Text(
                  "No",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Center(
                child: pw.Text(
                  "Deskripsi Barang",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Center(
                child: pw.Text(
                  "Qty",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Center(
                child: pw.Text(
                  "Harga",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Center(
                child: pw.Text(
                  "Total",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
  final lineTable = pw.Container(
    width: double.infinity,
    height: 0.5,
    color: PdfColors.black,
  );
}

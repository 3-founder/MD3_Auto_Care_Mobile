import 'package:pdf/widgets.dart' as pw;

class WidgetTextPdfPenawaran {
  final titleHormat = pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 40),
      pw.Text(
        "Dengan Hormat,",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "Bersama ini kami sampaikan penawaran harga \" Chemical \" untuk perawatan",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "mesin kendaraan sebagai berikut :",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
    ],
  );

  final titleCatatan = pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        "Catatan : ",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "Harga diatas belum termasuk PPN 11% ( bila menggunakan PPN )",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "1 Box isi 20 Pcs",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "Pembayaran Cash / DP 50 %",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        "Penyediaan barang segera setelah PO diterima",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:md3_auto_care/pdf/invoicePdf.dart';

class HistoryInvoice extends StatefulWidget {
  const HistoryInvoice({super.key});

  @override
  State<HistoryInvoice> createState() => _HistoryInvoiceState();
}

class _HistoryInvoiceState extends State<HistoryInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Invoice'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              InvoicePdf().printPdf();
            },
            child: Text("Generate Invoice"),
          )
        ],
      ),
    );
  }
}

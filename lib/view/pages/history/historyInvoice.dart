import 'package:flutter/material.dart';

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
    );
  }
}

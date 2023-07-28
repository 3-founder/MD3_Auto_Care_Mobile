import 'package:flutter/material.dart';

class DataInvoiceWidget {
  Column data(
    String noInvoice,
    String yth,
    String sales,
    String tanggal,
    String tanggalJatuhTempo,
    String penandaTangan,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("No Invoice",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 250,
                  child: Text(noInvoice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Yth",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 250,
                  child: Text(yth,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sales",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 250,
                  child: Text(sales,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tanggal",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 250,
                  child: Text(tanggal,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tanggal Jatuh Tempo",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 200,
                  child: Text(tanggalJatuhTempo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Penandatangan",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 250,
                  child: Text(penandaTangan,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

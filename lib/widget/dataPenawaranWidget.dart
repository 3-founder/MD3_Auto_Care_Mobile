import 'package:flutter/material.dart';

class DataPenawaranWidget {
  Column data(
    String noPenawaran,
    String halPenawaran,
    String namaCustomer,
    String tanggal,
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
                const Text("No Penawaran",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 200,
                  child: Text(noPenawaran,
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
                const Text("Hal Penawaran",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 200,
                  child: Text(halPenawaran,
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
                const Text("Nama Customer",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 200,
                  child: Text(namaCustomer,
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
                  width: 200,
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
                const Text("Penandatangan",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                SizedBox(
                  width: 200,
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

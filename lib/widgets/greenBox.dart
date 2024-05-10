import 'package:flutter/material.dart';

Widget greenBox() {
  return Container(
    height: 250,
    width: 250,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(85, 132, 122, 120.0000000),
      borderRadius: BorderRadius.circular(250),
    ),
  );
}
Widget greenBox2() {
  return Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(85, 132, 122, 120.0000000),
      borderRadius: BorderRadius.circular(250),
    ),
  );
}

Widget design() {
  return SizedBox(
    width: double.infinity,
    height: 135,
    child: Stack(
      children: [
        Positioned(
          top: -165,
          left: -35,
          child: greenBox(),
        ),
        Positioned(
          top: -115,
          left: -135,
          child: greenBox(),
        ),
      ],
    ),
  );
}
Widget design2() {
  return SizedBox(
    width: double.infinity,
    height: 160,
    child: Stack(
      children: [
        Positioned(
          bottom: 48,
          right: -90,
          child: greenBox2(),
        ),
        Positioned(
          bottom: -1,
          right: -70,
          child: greenBox2(),
        ),
      ],
    ),
  );
}

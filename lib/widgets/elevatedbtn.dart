import 'package:flutter/material.dart';

Widget elevatedBtn(yourText,{required onPress}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(85, 132, 122, 1)),

    //testing
    child: SizedBox(
      width: 200,
      child: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          yourText,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

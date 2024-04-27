import 'package:flutter/material.dart';

Widget myTextField(controller,text,{bool obscure=false}) {
  return SizedBox(
    height: 45,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12,left: 20),
          fillColor: Colors.white,
          filled: true,
          hintText: text,
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}

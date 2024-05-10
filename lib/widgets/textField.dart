import 'package:flutter/material.dart';

Widget myTextField(controller, text,
    {bool obscure = false,
    double paddingh = 20.0,
    submit,
    focusing = false,
    coloring = Colors.white,
    double paddingv = 0,
    onChange,
    searchIcon = ""}) {
  return SizedBox(
    height: 45,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingh, vertical: paddingv),
      child: TextField(
        autofocus: focusing,
        obscureText: obscure,
        controller: controller,
        onSubmitted: (_) => submit(),
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, left: 20),
          fillColor: coloring,
          filled: true,
          hintText:  '$searchIcon $text',
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}

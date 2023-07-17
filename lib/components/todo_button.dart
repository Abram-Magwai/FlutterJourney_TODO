import 'package:flutter/material.dart';

TextButton todoButton(Function()? func, String text) {
  return TextButton(
    onPressed: func,
    style: TextButton.styleFrom(
      backgroundColor: const Color.fromARGB(253, 83, 116, 95),
      padding: const EdgeInsets.symmetric(vertical: 15)
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

RichText textWithLink(BuildContext context, String text, String link, Widget page) {
  return RichText(
      text: TextSpan(
          text: '$text ',
          style: const TextStyle(color: Colors.black, fontSize: 17),
          children: [
        TextSpan(
          text: link,
          style: const TextStyle(
            color: Color.fromARGB(253, 83, 116, 95),
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle sign in button tap here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
        )
      ]));
}

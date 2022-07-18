import 'package:flutter/material.dart';

abstract class TVSTextStyle {
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle messageTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.white,
  );

  static const TextStyle underlinedTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.white,
    decoration: TextDecoration.underline,
  );
}

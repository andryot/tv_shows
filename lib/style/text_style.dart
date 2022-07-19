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

  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appBarTitleTextStyle = TextStyle(
    fontSize: 35,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

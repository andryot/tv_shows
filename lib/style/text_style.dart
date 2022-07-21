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

  static TextStyle appBarTitleTextStyle(Brightness brightness) => TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.dark ? Colors.white : Colors.black,
      );

  static const TextStyle showTileTitleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
}

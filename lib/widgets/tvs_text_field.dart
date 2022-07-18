import 'package:flutter/material.dart';

class TVSTextField extends StatelessWidget {
  final bool? obscureText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  const TVSTextField({
    Key? key,
    this.obscureText,
    this.labelText,
    this.controller,
    this.suffixIcon,
    this.textInputType,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TVSTextField extends StatelessWidget {
  final bool? obscureText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? color;
  final Color? labelColor;
  final void Function(String?)? onChanged;
  const TVSTextField({
    Key? key,
    this.obscureText,
    this.labelText,
    this.controller,
    this.suffixIcon,
    this.textInputType,
    this.textInputAction,
    this.color,
    this.labelColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      controller: controller,
      style: TextStyle(color: color ?? Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor ?? Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color ?? Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color ?? Colors.white,
            width: 2,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

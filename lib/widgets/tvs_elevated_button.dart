import 'package:flutter/material.dart';

import '../style/colors.dart';
import 'tvs_loading_indicator.dart';

class TVSElevatedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool? enabled;
  final bool? isLoading;
  const TVSElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      clipBehavior: Clip.hardEdge,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          enabled == true
              ? TVSColors.enabledButtonColor
              : TVSColors.disabledButtonColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      onPressed: enabled == false
          ? null
          : isLoading == true
              ? null
              : onPressed,
      child: isLoading == true
          ? const TVSLoadingIndicator(radius: 11.2, dotRadius: 4.77)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: enabled == true
                      ? TVSColors.enabledButtonChildColor
                      : TVSColors.disabledButtonChildColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
    );
  }
}

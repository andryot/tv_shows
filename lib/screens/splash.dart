import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../routes/routes.dart';
import '../style/colors.dart';
import '../style/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, TVSRoutes.login),
    );

    return Scaffold(
      backgroundColor: TVSColors.primaryColor,
      body: Stack(
        children: [
          Hero(
            tag: 'logo',
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                TVSImages.logo,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              TVSImages.topLeft,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              TVSImages.topRight,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              TVSImages.bottomLeft,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              TVSImages.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}

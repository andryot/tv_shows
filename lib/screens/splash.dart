import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/splash/splash_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../routes/routes.dart';
import '../services/keychain_service.dart';
import '../style/colors.dart';
import '../style/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        keychainService: KeychainService.instance,
      ),
      child: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.redirectTo != null) {
          if (state.themeMode != null) {
            BlocProvider.of<ThemeCubit>(context).setTheme(state.themeMode!);
          }

          if (state.redirectTo! == TVSRoutes.showList) {
            BlocProvider.of<GlobalBloc>(context).updateUser(state.user!);
          }
          Navigator.of(context).pushReplacementNamed(state.redirectTo!);
        }
      },
      child: Scaffold(
        backgroundColor: TVSColors.primaryColorLight,
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
      ),
    );
  }
}

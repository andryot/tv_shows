import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../routes/routes.dart';
import '../services/backend_service.dart';
import '../style/colors.dart';
import '../style/icons.dart';
import '../style/images.dart';
import '../style/text_style.dart';
import '../widgets/tvs_elevated_button.dart';
import '../widgets/tvs_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        backendService: BackendService.instance,
      ),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // redirect to show_list screen if login is successful
        if (state.user != null) {
          BlocProvider.of<GlobalBloc>(context).updateUser(state.user!);
          Navigator.of(context).pushReplacementNamed(TVSRoutes.showList);
        }
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: TVSColors.primaryColor,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(TVSImages.topRight),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(TVSImages.topLeft),
              ),
              Hero(
                tag: 'logo',
                child: Align(
                  heightFactor: 5.5,
                  widthFactor: 1.7,
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    TVSImages.logo,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final LoginBloc bloc = BlocProvider.of(context);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Login",
                            style: TVSTextStyle.headerTextStyle,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "In order to continue please log in.",
                            style: TVSTextStyle.messageTextStyle,
                          ),
                          const SizedBox(height: 20),
                          TVSTextField(
                            labelText: "Email",
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: bloc.emailEditingController,
                          ),
                          const SizedBox(height: 20),
                          TVSTextField(
                            labelText: "Password",
                            obscureText: state.isPasswordToggled,
                            textInputType: TextInputType.visiblePassword,
                            controller: bloc.passwordEditingController,
                            suffixIcon: GestureDetector(
                              onTap: bloc.togglePassword,
                              child: SvgPicture.asset(
                                state.isPasswordToggled
                                    ? TVSIcons.showPassword
                                    : TVSIcons.hidePassword,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          if (state.failure != null) ...[
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                "Login failed!",
                                style: TVSTextStyle.errorTextStyle,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ] else
                            const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              "Create account",
                              style: TVSTextStyle.underlinedTextStyle,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    bottom: paddingBottom + (Platform.isAndroid ? 20 : 0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final LoginBloc bloc =
                            BlocProvider.of<LoginBloc>(context);
                        return TVSElevatedButton(
                          isLoading: state.isLoading,
                          text: "Login",
                          onPressed: () => bloc.login(
                            bloc.emailEditingController.text,
                            bloc.passwordEditingController.text,
                          ),
                          enabled: state.isButtonEnabled,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

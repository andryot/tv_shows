import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../routes/routes.dart';
import '../../services/keychain_service.dart';
import '../../style/themes.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final KeychainService _keychainService;

  SplashBloc({required KeychainService keychainService})
      : _keychainService = keychainService,
        super(const SplashState.initial()) {
    on<_InitializeEvent>(_onInitialize);

    add(const _InitializeEvent());
  }

  FutureOr<void> _onInitialize(
      _InitializeEvent event, Emitter<SplashState> emit) async {
    final List<dynamic> results = await Future.wait(<Future<dynamic>>[
      _keychainService.readUser(),
      _keychainService.readThemeMode(),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    final User? user = results.first as User?;
    final AppTheme? appTheme = results[1] as AppTheme?;

    late final ThemeMode themeMode;

    if (appTheme == null || appTheme == AppTheme.light) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }

    final int currentSecondsSinceEpoch =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Redirect to login if no user is found or the user is expired.
    if (user == null ||
        user.expiry == null ||
        user.expiry! < currentSecondsSinceEpoch) {
      emit(state.copyWith(
        redirectTo: TVSRoutes.login,
        themeMode: themeMode,
      ));
    } else {
      emit(state.copyWith(
        user: user,
        redirectTo: TVSRoutes.showList,
        themeMode: themeMode,
      ));
    }
  }
}

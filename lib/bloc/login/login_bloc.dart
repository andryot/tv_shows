import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../util/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<_LoginEvent, LoginState> {
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;

  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;

  LoginBloc() : super(const LoginState.initial()) {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();

    on<_TogglePressedEvent>(_onTogglePressed);
    on<_LoginPressedEvent>(_onLoginPressed);
  }

  // PUBLIC API
  void togglePassword() => add(const _TogglePressedEvent());
  void login() => add(const _LoginPressedEvent());

  // HANDLERS

  FutureOr<void> _onTogglePressed(
      _TogglePressedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordToggled: !state.isPasswordToggled));
  }

  FutureOr<void> _onLoginPressed(
      _LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(isLoading: false));
  }
}

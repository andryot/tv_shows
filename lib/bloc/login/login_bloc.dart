import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';
import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<_LoginEvent, LoginState> {
  final BackendService _backendService;
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;

  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;

  LoginBloc({required BackendService backendService})
      : _backendService = backendService,
        super(const LoginState.initial()) {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();

    _emailEditingController
        .addListener(() => add(const _EmailOrPasswordChangedEvent()));
    _passwordEditingController
        .addListener(() => add(const _EmailOrPasswordChangedEvent()));

    on<_TogglePressedEvent>(_onTogglePressed);
    on<_LoginPressedEvent>(_onLoginPressed);

    on<_EmailOrPasswordChangedEvent>(_onEmailOrPasswordChanged);
  }

  @override
  Future<void> close() async {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    await super.close();
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

    final Either<Failure, User> userOrFailure = await _backendService.login(
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
    );

    if (userOrFailure.isError()) {
      emit(state.copyWith(
        isLoading: false,
        failure: userOrFailure.error,
      ));
      return null;
    }

    //await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(
      isLoading: false,
      user: userOrFailure.value,
    ));
  }

  FutureOr<void> _onEmailOrPasswordChanged(
      _EmailOrPasswordChangedEvent event, Emitter<LoginState> emit) {
    if (shouldButtonBeEnabled()) {
      if (state.isButtonEnabled) return null;
      emit(state.copyWith(isButtonEnabled: true));
    } else if (state.isButtonEnabled) {
      emit(state.copyWith(isButtonEnabled: false));
    }
  }

  bool shouldButtonBeEnabled() {
    return (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty);
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../services/backend_service.dart';
import '../../services/keychain_service.dart';
import '../../util/either.dart';
import '../../util/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<_LoginEvent, LoginState> {
  final BackendService _backendService;
  final KeychainService _keychainService;
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;

  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;

  LoginBloc({
    required BackendService backendService,
    required KeychainService keychainService,
  })  : _backendService = backendService,
        _keychainService = keychainService,
        super(const LoginState.initial()) {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();

    /*  _emailEditingController
        .addListener(() => add(const _EmailOrPasswordChangedEvent()));
    _passwordEditingController
        .addListener(() => add(const _EmailOrPasswordChangedEvent())); */

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
  void login(String email, String password) =>
      add(_LoginPressedEvent(email, password));

  void onChanged() => add(const _EmailOrPasswordChangedEvent());

  // HANDLERS

  FutureOr<void> _onTogglePressed(
      _TogglePressedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordToggled: !state.isPasswordToggled));
  }

  FutureOr<void> _onLoginPressed(
      _LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final Either<Failure, User> userOrFailure = await _backendService.login(
      email: event.email,
      password: event.password,
    );

    if (userOrFailure.isError()) {
      emit(state.copyWith(
        isLoading: false,
        failure: userOrFailure.error,
      ));
      return null;
    }

    await _keychainService.saveUser(userOrFailure.value);

    emit(state.copyWith(
      isLoading: false,
      user: userOrFailure.value,
    ));
  }

  FutureOr<void> _onEmailOrPasswordChanged(
      _EmailOrPasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(turns: state.turns - 0.2));
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

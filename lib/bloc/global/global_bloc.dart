import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../routes/routes.dart';
import '../../services/keychain_service.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<_GlobalEvent, GlobalState> {
  final KeychainService _keychainService;
  GlobalBloc({
    required KeychainService keychainService,
  })  : _keychainService = keychainService,
        super(const GlobalState.initial()) {
    on<_UpdateUserEvent>(_onUpdateUser);
    on<_LogoutEvent>(_onLogout);
  }
  // PUBLIC API

  void updateUser(User user) => add(_UpdateUserEvent(user));
  void logout(BuildContext context) => add(_LogoutEvent(context));

  // HANDLERS

  FutureOr<void> _onUpdateUser(
      _UpdateUserEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(user: event.user));
  }

  FutureOr<void> _onLogout(
      _LogoutEvent event, Emitter<GlobalState> emit) async {
    Navigator.pushReplacementNamed(event.context, TVSRoutes.login);
    await _keychainService.removeUser();
    emit(const GlobalState.initial());
  }
}

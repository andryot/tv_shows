import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';
import '../../routes/routes.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<_GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState.initial()) {
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

  FutureOr<void> _onLogout(_LogoutEvent event, Emitter<GlobalState> emit) {
    emit(const GlobalState.initial());
    Navigator.pushReplacementNamed(event.context, TVSRoutes.login);
  }
}

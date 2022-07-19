import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<_GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState.initial()) {
    on<_UpdateUserEvent>(_onUpdateUser);
  }
  // PUBLIC API

  void updateUser(User user) => add(_UpdateUserEvent(user));

  // HANDLERS

  FutureOr<void> _onUpdateUser(
      _UpdateUserEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(user: event.user));
  }
}

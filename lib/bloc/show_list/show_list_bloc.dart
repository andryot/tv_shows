import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/show.dart';
import '../../model/user.dart';
import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failure.dart';

part 'show_list_event.dart';
part 'show_list_state.dart';

class ShowListBloc extends Bloc<_ShowListEvent, ShowListState> {
  final User _user;
  final BackendService _backendService;
  ShowListBloc({
    required User user,
    required BackendService backendService,
  })  : _user = user,
        _backendService = backendService,
        super(const ShowListState.initial()) {
    on<_InitializeEvent>(_onInitialize);
    on<_ReloadEvent>(_onReload);

    add(const _InitializeEvent());
  }

  // PUBLIC API
  void refresh() => add(const _ReloadEvent());

  FutureOr<void> _onInitialize(
      _InitializeEvent event, Emitter<ShowListState> emit) async {
    final Either<Failure, List<Show>> showsOrFailure =
        await _backendService.getShows(
      user: _user,
    );

    if (showsOrFailure.isError()) {
      // TODO
      return null;
    }
    emit(state.copyWith(shows: showsOrFailure.value));
  }

  FutureOr<void> _onReload(_ReloadEvent event, Emitter<ShowListState> emit) {
    emit(state.copyWith(shows: null, overrideShows: true));
    add(const _InitializeEvent());
  }
}

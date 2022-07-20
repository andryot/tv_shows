part of 'show_list_bloc.dart';

@immutable
class ShowListState {
  final List<Show>? shows;

  final Failure? failure;

  const ShowListState({
    this.shows,
    this.failure,
  });

  const ShowListState.initial()
      : shows = null,
        failure = null;

  ShowListState copyWith({
    List<Show>? shows,
    bool? overrideShows,
    Failure? failure,
  }) {
    return ShowListState(
      shows: overrideShows == true ? shows : shows ?? this.shows,
      failure: failure,
    );
  }
}

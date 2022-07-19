part of 'show_list_bloc.dart';

@immutable
class ShowListState {
  final List<Show>? shows;

  const ShowListState({
    this.shows,
  });

  const ShowListState.initial() : shows = null;

  ShowListState copyWith({
    List<Show>? shows,
    bool? overrideShows,
  }) {
    return ShowListState(
      shows: overrideShows == true ? shows : shows ?? this.shows,
    );
  }
}

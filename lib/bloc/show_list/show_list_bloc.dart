import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_list_event.dart';
part 'show_list_state.dart';

class ShowListBloc extends Bloc<ShowListEvent, ShowListState> {
  ShowListBloc() : super(ShowListInitial()) {
    on<ShowListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

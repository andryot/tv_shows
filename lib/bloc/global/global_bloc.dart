import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState.initial()) {}
}

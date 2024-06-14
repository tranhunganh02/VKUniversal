import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc()
      : super(BottomNavigationStateInitial(selectedIndex: 0)) {
    on<TabTapped>((event, emit) {
      emit(BottomNavigationStateInitial(selectedIndex: event.selectedIndex));
    });
  }
}

part of 'home_bloc.dart';

@immutable
sealed class BottomNavigationEvent extends Equatable {}

class TabTapped extends BottomNavigationEvent {
  final int selectedIndex;
  TabTapped(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

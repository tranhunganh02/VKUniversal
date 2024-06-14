part of 'home_bloc.dart';

@immutable
sealed class BottomNavigationState extends Equatable {}

final class BottomNavigationStateInitial extends BottomNavigationState {
  final int selectedIndex;

  BottomNavigationStateInitial({required this.selectedIndex});
  @override
  List<Object?> get props => [selectedIndex];
}

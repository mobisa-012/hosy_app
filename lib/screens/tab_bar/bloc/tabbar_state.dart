part of 'tabbar_bloc.dart';

@immutable
abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class TabBarItemSelectedState extends TabBarState {
  final int index;

  TabBarItemSelectedState(this.index);

  
}

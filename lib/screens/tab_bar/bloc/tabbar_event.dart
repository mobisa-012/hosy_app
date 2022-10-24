part of 'tabbar_bloc.dart';

@immutable

abstract class TabBarEvent {}

 class TabBarItemTappedEvent extends TabBarEvent{
  final int index;

  TabBarItemTappedEvent(this.index);

  
}

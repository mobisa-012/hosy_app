import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tabbar_state.dart';
part 'tabbar_event.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial());

  int currentIndex = 0;
  bool isSelected = false;

  Stream<TabBarState> mapEventToState(TabBarEvent event) async* {
    if (event is TabBarItemTappedEvent) {
      currentIndex = event.index;
      yield TabBarItemSelectedState(currentIndex);
    }
  }
}

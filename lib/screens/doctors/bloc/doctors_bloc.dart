import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {

  DoctorsBloc() : super(DoctorsInitial());

  Stream<DoctorsState> mapEventToState(DoctorsEvent event) async* {
    if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is DoctorCallTappedEvent) {
      yield DoctorCallTappedState();
    }
  }
}

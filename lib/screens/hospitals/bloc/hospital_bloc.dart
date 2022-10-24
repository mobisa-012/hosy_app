import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalBloc() : super(HospitalInitial());

  Stream<HospitalState> mapEventToState(HospitalEvent event) async* {
    if (event is HospitalCallEvent) {
      yield HospitalCallState();
    }
    if (event is HospitalInfoEvent) {
      yield HospitalInfoState();
    }
  }
}

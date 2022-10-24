part of'doctors_bloc.dart';

@immutable
abstract class DoctorsEvent{}

class BackTappedEvent extends DoctorsEvent {}

class DoctorCallTappedEvent extends DoctorsEvent {}
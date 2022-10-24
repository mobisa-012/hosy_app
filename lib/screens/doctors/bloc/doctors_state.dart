part of'doctors_bloc.dart';

@immutable
abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState{}

class BackTappedState extends DoctorsState {}

class DoctorCallTappedState extends DoctorsState{}
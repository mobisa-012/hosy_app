part of 'hospital_bloc.dart';

@immutable
abstract class HospitalState {}

class HospitalInitial extends HospitalState{}

class HospitalCallState extends HospitalState{}

class HospitalInfoState extends HospitalState{}
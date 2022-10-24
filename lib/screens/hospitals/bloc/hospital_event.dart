part of'hospital_bloc.dart';

@immutable
abstract class HospitalEvent{}

class HospitalCallEvent extends HospitalEvent{}

class HospitalInfoEvent extends HospitalEvent{}
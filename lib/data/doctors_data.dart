
import 'package:hosy/data/doctor_details.dart';

class DoctorData {
  final String name;
  final String image;
  final String specialty;
  final List<DoctorsDetails> doctorDetailsList;
  final String yearsOfExperience;

  DoctorData(
      {required this.yearsOfExperience,
      required this.image,
      required this.doctorDetailsList,
      required this.name,
      required this.specialty});

  @override
  String toString() {
    return 'DoctortData(name: $name, specialty: $specialty, yearsOfExperience: $yearsOfExperience, doctorDetailsList: $doctorDetailsList,)';
  }
}

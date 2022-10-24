import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/const/text_constants.dart';
import 'package:hosy/data/doctor_details.dart';
import 'package:hosy/data/doctors_data.dart';
import 'package:hosy/screens/onboarding/widget/onbardingtile.dart';

class DataConstants {
  static final onboardingTiles = [
    const OnboardingTile(
      title: TextConstants.needAmbulance,
      imagePath: PathConstants.ambulance,
      mainText: TextConstants.onboardingTile1,
    ),
    const OnboardingTile(
      title: TextConstants.needDoctor,
      imagePath: PathConstants.doctor,
      mainText: TextConstants.onboardingTile2,
    ),
    const OnboardingTile(
      title: TextConstants.haveAnEmergency,
      imagePath: PathConstants.emergency,
      mainText: TextConstants.onboardingTile3,
    ),
  ];

  static final List<DoctorData> doctorsDataPage = [
    DoctorData(
      yearsOfExperience: '5',
      image: PathConstants.profile1,
      doctorDetailsList: [
        DoctorsDetails(child: true, title: ''),
      ],
      name: TextConstants.name1,
      specialty: TextConstants.specialty5,
    ),
    DoctorData(
      yearsOfExperience: '3',
      image: PathConstants.profile1,
      doctorDetailsList: [
        DoctorsDetails(
            child: true,
            title: '${TextConstants.call}or${TextConstants.textMe}'),
      ],
      name: TextConstants.name2,
      specialty: TextConstants.specialty1,
    ),
    DoctorData(
      yearsOfExperience: '2',
      image: PathConstants.profile1,
      doctorDetailsList: [
        DoctorsDetails(
            child: true,
            title: '${TextConstants.call}or${TextConstants.textMe}'),
      ],
      name: TextConstants.name3,
      specialty: TextConstants.specialty3,
    ),
    DoctorData(
      yearsOfExperience: '8',
      image: PathConstants.profile1,
      doctorDetailsList: [
        DoctorsDetails(
            child: true,
            title: '${TextConstants.call}or${TextConstants.textMe}'),
      ],
      name: TextConstants.name3,
      specialty: TextConstants.specialty2,
    ),
    DoctorData(
      yearsOfExperience: '2',
      image: PathConstants.profile1,
      doctorDetailsList: [
        DoctorsDetails(
            child: true,
            title: '${TextConstants.call}or${TextConstants.textMe}'),
      ],
      name: TextConstants.name4,
      specialty: TextConstants.specialty4,
    ),
  ];
}

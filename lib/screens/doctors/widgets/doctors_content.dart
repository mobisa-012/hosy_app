import 'package:flutter/material.dart';
import 'package:hosy/core/const/colors.dart';
import 'package:hosy/core/const/dataconstants.dart';
import 'package:hosy/core/const/text_constants.dart';
import 'package:hosy/screens/common_widgets/doctors_card.dart';
import 'package:hosy/screens/doctor_details/page/doctors_details_page.dart';


class DoctorsContent extends StatelessWidget {
  const DoctorsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(scrollDirection: Axis.vertical, children: [
      _createFindDoctor(context),
      const SizedBox(
        height: 35,
      ),
      _createDoctorsCard(context),
    ]));
  }

  Widget _createFindDoctor(BuildContext context) {
    return Container(
        height: 80,
        decoration: const BoxDecoration(color: AppColors.homeBackground),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(
            TextConstants.doctor,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              fillColor: AppColors.homeBackground,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(width: 0.8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      width: 0.8, color: Theme.of(context).primaryColor)),
              hintText: TextConstants.findDoctor,
              prefixIcon: const Icon(
                Icons.search,
                size: 25,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
            ),
          )
        ]));
  }

  Widget _createDoctorsCard(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        DoctorsCard(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DoctorDetailsPage())),
          withImage: true,
          doctorData: DataConstants.doctorsDataPage[0],
          color: AppColors.caidiologist,
        ),
        const SizedBox(
          height: 15,
        ),
        DoctorsCard(
            color: AppColors.gynacologist,
            doctorData: DataConstants.doctorsDataPage[4],
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DoctorDetailsPage())),
            withImage: true),
        const SizedBox(
          height: 15,
        ),
        DoctorsCard(
            color: AppColors.opthamologist,
            doctorData: DataConstants.doctorsDataPage[2],
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DoctorDetailsPage())),
            withImage: true),
        const SizedBox(
          height: 15,
        ),
        DoctorsCard(
            color: AppColors.peaditrician,
            doctorData: DataConstants.doctorsDataPage[3],
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DoctorDetailsPage())),
            withImage: true),
        const SizedBox(
          height: 15,
        ),
        DoctorsCard(
            color: AppColors.clinician,
            doctorData: DataConstants.doctorsDataPage[4],
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DoctorDetailsPage())),
            withImage: true),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hosy/core/const/colors.dart';
import 'package:hosy/data/doctors_data.dart';

class DoctorsCard extends StatelessWidget {
  final Color color;
  final DoctorData doctorData;
  final Function() onTap;
  final bool withImage;

  const DoctorsCard(
      {super.key,
      required this.color,
      required this.doctorData,
      required this.onTap,
      required this.withImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      doctorData.name,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    ),
                    Text(
                      doctorData.specialty,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    ),
                    Text(
                      doctorData.yearsOfExperience,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    )
                  ],
                )
              ],
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Image(
                  image: AssetImage(doctorData.image),
                ))
          ],
        ),
      ),
    );
  }
}

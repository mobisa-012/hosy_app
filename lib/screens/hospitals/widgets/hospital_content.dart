// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:hosy/core/const/colors.dart';
import 'package:hosy/core/const/text_constants.dart';
import 'package:hosy/screens/common_widgets/hospital_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalContent extends StatelessWidget {
  const HospitalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.homeBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                TextConstants.hospitals,
                style: TextStyle(
                    fontSize: 19,
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
                  hintText: TextConstants.findHospital,
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
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Karen Hospital',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://karenhospital.org';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Moi Referral',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://www.mtrh.go.ke';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Kenyatta Hospital',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://knh.or.ke';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Kisii Referral Hospital',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://ktrh.or.ke';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Nairobi West',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://nairobiwesthospital.com';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        HospitalCard(
          withCall: true,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Aga Khan Hospital',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    const url = 'https://hospitals.aku.edu';
                    openBrowserURL(url: url, inApp: true);
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                    color: AppColors.buttonColor,
                  ))
            ],
          ),
        ),
      ],
    ));
  }

  Future openBrowserURL({required String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
  }
}

// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/const/colors.dart';
import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/const/text_constants.dart';
import 'package:hosy/screens/common_widgets/profile_container.dart';
import 'package:hosy/screens/edit_account/page/edit_account.dart';
import 'package:hosy/screens/profile/bloc/profile_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<ProfileBloc> _buildContext(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        buildWhen: (_, currState) => currState is ProfileInitial,
        builder: (context, state) {
          return _profileContents(context);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _profileContents(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'No username';
    photoUrl = user?.photoURL;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Center(
                  child: photoUrl == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(PathConstants.profile1),
                          radius: 60,
                        )
                      : CircleAvatar(
                          radius: 60,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: PathConstants.profile1,
                              image: photoUrl!,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 120,
                            ),
                          ),
                        ),
                ),
                TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ));
                      setState(() {
                        photoUrl = user?.photoURL;
                      });
                    },
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor:
                            AppColors.buttonColor.withOpacity(0.16)),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.buttonColor,
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              displayName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileContainer(
                onTap: () {
                  Share.share(
                      'You can call an ambulance and book an appointment with any doctor!!',
                      subject: 'Look what I found!');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PathConstants.invite),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      TextConstants.inviteFriends,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            if (!kIsWeb)
              ProfileContainer(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PathConstants.history),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      TextConstants.history,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ProfileContainer(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PathConstants.help),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      TextConstants.help,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            ProfileContainer(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PathConstants.payment),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      TextConstants.paymentMethod,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            ProfileContainer(
                onTap: () {
                  return launch(Platform.isIOS
                      ? 'https://www.apple.com/app-store'
                      : 'https://play.google.com/store');
                },
                child: Row(
                  children: [
                    Text(
                      '${TextConstants.rateUsOn}${Platform.isIOS ? 'App store' : 'Play store'}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            const Text(
              TextConstants.joinUsOn,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => launch('https://www.facebook.com/hosy/'),
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: Image.asset(PathConstants.facebook)),
                TextButton(
                  onPressed: () => launch('https://www.instagram.com/hosy/'),
                  style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 1),
                  child: Image.asset(PathConstants.instagram),
                ),
                TextButton(
                  onPressed: () => launch('https://www.twitter.com/hosy/'),
                  style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 1),
                  child: Image.asset(PathConstants.twitter),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

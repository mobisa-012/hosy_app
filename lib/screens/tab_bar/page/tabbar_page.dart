import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/const/colors.dart';
import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/const/text_constants.dart';
import 'package:hosy/screens/doctors/page/doctors_page.dart';
import 'package:hosy/screens/home/page/homepage.dart';
import 'package:hosy/screens/hospitals/page/hospotals_page.dart';
import 'package:hosy/screens/profile/page/profile_page.dart';
import 'package:hosy/screens/tab_bar/bloc/tabbar_bloc.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createBottomNavBar(context),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _createBottomNavBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: AppColors.iconColor,
      items: [
        BottomNavigationBarItem(
          icon: Image(
            image: const AssetImage(PathConstants.home),
            color: bloc.currentIndex == 0 ? AppColors.iconColor : null,
          ),
          label: TextConstants.home,
        ),
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.hospital),
              color: bloc.currentIndex == 1 ? AppColors.iconColor : null,
            ),
            label: TextConstants.hospitals),
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.call),
              color: bloc.currentIndex == 2 ? AppColors.iconColor : null,
            ),
            label: TextConstants.doctor),
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.profile),
              color: bloc.currentIndex == 3 ? AppColors.iconColor : null,
            ),
            label: TextConstants.profile)
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      const HomePage(),
      const Hospitals(),
      const Doctors(),
      const Profile()
    ];
    return children[index];
  }
}

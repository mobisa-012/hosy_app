import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_confirmed_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_home_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_map.dart';
import 'package:hosy/screens/home/widgets/home_app_bar.dart';
import 'package:hosy/screens/home/widgets/home_drawer.dart';


import '../widgets/destination_selection_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AmbulanceBookingBloc>(context).add(BackPressedEvent());
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          endDrawer: const HomeDrawer(),
          body: Stack(
            children: const <Widget>[AmbulanceMap(), HomeAppBar()],
          ),
          bottomSheet: BlocBuilder<AmbulanceBookingBloc, AmbulanceBookingState>(
              builder: (BuildContext context, AmbulanceBookingState state) {
            if (state is AmbulanceBookingNotInitializedState) {
              return Container();
            }
            if (state is AmbulanceBookingNotSelectedState) {
              return const DestinationSelctionWidget();
            }
            if (state is AmbulanceBookingConfirmedState) {
              return const AmbulanceBookingConfirmedWidget();
            }
            return const AmbulanceBookingHomeWidget();
          }),
        ),
      ),
    );
  }
}

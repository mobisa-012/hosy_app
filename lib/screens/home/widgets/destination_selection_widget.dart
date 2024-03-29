// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/user_location.dart';
import 'package:hosy/data/user_location_controller.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/widgets/ease_in_widget.dart';


class DestinationSelctionWidget extends StatefulWidget {
  const DestinationSelctionWidget({super.key});

  @override
  _DestinationSelctionWidgetState createState() =>
      _DestinationSelctionWidgetState();
}

class _DestinationSelctionWidgetState extends State<DestinationSelctionWidget>
    with TickerProviderStateMixin<DestinationSelctionWidget> {
  late bool isLoading;
  late List<UserLocation> savedLocations;
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      loadDestinations();
    });
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      curve: Curves.easeInExpo,
      parent: animationController,
    );
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      animationController.forward();
    });
  }

  Future<void> loadDestinations() async {
    setState(() {
      isLoading = true;
    });
    savedLocations = await UserLocationController.getSavedLocations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return SizedBox(
                height: 150.0 * animation.value,
                child: child,
              );
            },
            child: Container(
              height: 150.0,
              color: Colors.transparent,
              child: ListView.builder(
                itemBuilder: (context, index) => SingleChildScrollView(
                  child: index == 0
                      ? buildNewDestinationWidget()
                      : buildDestinationWidget(savedLocations[index - 1]),
                ),
                shrinkWrap: true,
                itemCount: savedLocations.length + 1,
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
  }

  Widget buildDestinationWidget(UserLocation location) {
    return EaseInWidget(
        onTap: () {
          selectDestination(location.position);
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 15.0,
                    spreadRadius: 0.05),
              ],
              borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffeeeeee),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  location.locationType == UserLocationType.home
                      ? Icons.home
                      : Icons.work,
                  size: 22.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                location.locationType.toString().replaceFirst("UserLocationType.", ""),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "${location.minutesFar} minutes",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 12.0),
              )
            ],
          ),
        ));
  }

  Widget buildNewDestinationWidget() {
    return EaseInWidget(
      onTap: () {
        selectDestination(const LatLng(0, 0));
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 15.0,
                  spreadRadius: 0.05),
            ],
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.my_location,
                size: 22.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "New Ride",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              "Select Dest.",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }

  void selectDestination(LatLng position) async {
    await animationController.reverse(from: 1.0);
    BlocProvider.of<AmbulanceBookingBloc>(context)
        .add(DestinationSelectedEvent(destination: position));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_driver.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_cancellation_dialog.dart';


class AmbulanceBookingConfirmedWidget extends StatefulWidget {
  const AmbulanceBookingConfirmedWidget({super.key});

  @override
  AmbulanceBookingConfirmedWidgetState createState() =>
      AmbulanceBookingConfirmedWidgetState();
}

class AmbulanceBookingConfirmedWidgetState
    extends State<AmbulanceBookingConfirmedWidget>
    with TickerProviderStateMixin<AmbulanceBookingConfirmedWidget> {
  late AnimationController animationController;
  late Animation animation;
  late AmbulanceDriver driver;
  late AmbulanceBooking booking;

  @override
  void initState() {
    super.initState();
    booking = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as AmbulanceBookingConfirmedState)
        .booking;
    driver = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as AmbulanceBookingConfirmedState)
        .driver;
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: animationController,
    );
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    child: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Ride Info",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const AmbulanceBookingCancellationDialog());
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )),
                Container(
                  color: Colors.black,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      color: Colors.white,
                      child: buildDriver(),
                    ),
                  ),
                )
              ]),
        ),
        builder: (context, child) {
          return SizedBox(
            height: 200.0 * animation.value,
            child: child,
          );
        });
  }

  Widget buildDriver() {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            driver.driverPic,
            width: 48.0,
            height: 48.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              driver.driverName,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              driver.ambulanceDetails,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        )),
        const SizedBox(
          width: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffeeeeee).withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20.0,
              ),
              Text(
                "${driver.driverRating}",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        )
      ],
    );
  }
}

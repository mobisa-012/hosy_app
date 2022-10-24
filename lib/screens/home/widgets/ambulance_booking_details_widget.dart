// ignore_for_file: unnecessary_null_comparison, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/rounded_button.dart';

class AmbulanceBookingDetailsWidget extends StatefulWidget {
  const AmbulanceBookingDetailsWidget({super.key});

  @override
  AmbulanceBookingDetailsWidgetState createState() =>
      AmbulanceBookingDetailsWidgetState();
}

class AmbulanceBookingDetailsWidgetState
    extends State<AmbulanceBookingDetailsWidget> {
  late GoogleLocation source, destination;
  late int noOfPersons;
  late DateTime bookingTime;

  @override
  void initState() {
    super.initState();
    AmbulanceBooking ambulanceBooking =
        (BlocProvider.of<AmbulanceBookingBloc>(context).state
                as DetailsNotFilledState)
            .booking;
    noOfPersons = ambulanceBooking.noOfPersons;
    bookingTime = ambulanceBooking.bookingTime;
    source = ambulanceBooking.source;
    destination = ambulanceBooking.destination;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Address",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                buildInputWidget(source.areaDetails, "hint", () {}),
                const SizedBox(
                  height: 16.0,
                ),
                buildInputWidget(
                    destination.areaDetails, "Enter your destination", () {}),
                const SizedBox(
                  height: 36.0,
                ),
                Text(
                  "Seat and Time",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                buildPersonSelector(),
                const SizedBox(
                  height: 24.0,
                ),
                buildTimeSelector()
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            RoundedButton(
              onTap: () {
                BlocProvider.of<AmbulanceBookingBloc>(context)
                    .add(BackPressedEvent());
              },
              iconData: Icons.keyboard_backspace,
              text: '',
            ),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              flex: 2,
              child: RoundedButton(
                text: "See Next",
                onTap: () {
                  BlocProvider.of<AmbulanceBookingBloc>(context).add(
                      DetailsSubmittedEvent(
                          bookingTime: bookingTime,
                          destination: destination,
                          source: source,
                          noOfPersons: noOfPersons));
                },
                iconData: Icons.arrow_forward,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildPersonSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Need Seat",
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3]
              .map((val) => GestureDetector(
                  onTap: () {
                    setState(() {
                      noOfPersons = val;
                    });
                  },
                  child: buildContainer("$val", val == noOfPersons)))
              .toList(),
        )
      ],
    );
  }

  Widget buildTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Schedule Time",
              style: Theme.of(context).textTheme.headline6,
            ),
            bookingTime == null
                ? Container()
                : Text(
                    "${bookingTime.day}-${bookingTime.month}-${bookingTime.year}",
                    style: Theme.of(context).textTheme.subtitle2,
                  )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTimeContainer(
                text: "Now",
                enabled: bookingTime == null,
                onTap: () {
                  setState(() {
                    bookingTime;
                  });
                }),
            buildTimeContainer(
                iconData: Icons.timer,
                enabled: bookingTime != null,
                onTap: () async {
                  DateTime? time = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now()..add(const Duration(days: 1)),
                    initialDatePickerMode: DatePickerMode.day,
                  );
                  setState(() {
                    bookingTime = time!;
                  });
                })
          ],
        )
      ],
    );
  }

  Widget buildContainer(String val, bool enabled) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: enabled ? Colors.black : const Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          val,
          style: Theme.of(context).textTheme.headline5?.copyWith(
              color: enabled ? Colors.white : Colors.black, fontSize: 15.0),
        ));
  }

  Widget buildTimeContainer(
      {String? text,
      IconData? iconData,
      bool enabled = false,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: enabled ? Colors.black : const Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(12.0)),
          child: text != null
              ? Text(
                  text,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: enabled ? Colors.white : Colors.black,
                      fontSize: 15.0),
                )
              : Icon(
                  iconData,
                  color: enabled ? Colors.white : Colors.black,
                  size: 18.0,
                )),
    );
  }

  Widget buildInputWidget(String text, String hint, Function() onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xffeeeeee).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: text == null ? Colors.black45 : Colors.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

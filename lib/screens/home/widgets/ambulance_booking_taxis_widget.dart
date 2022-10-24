// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/rounded_button.dart';

class AmbulanceBookingAmbulanceWidget extends StatefulWidget {
  @override
  AmbulanceWidgetState createState() => AmbulanceWidgetState();
}

class AmbulanceWidgetState extends State<AmbulanceBookingAmbulanceWidget> {
  late AmbulanceBooking ambulanceBooking;
  final List<AmbulanceTypes> ambulanceTypes = [
    AmbulanceTypes.standard,
    AmbulanceTypes.premium,
    AmbulanceTypes.platinum
  ];
  @override
  void initState() {
    super.initState();
    ambulanceBooking = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as AmbulanceNotSelectedState)
        .booking;
    selectedAmbulanceType = ambulanceBooking.ambulanceType;
    if (selectedAmbulanceType == null) {
      selectedAmbulanceType = AmbulanceTypes.standard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Choose Ambulance",
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildAmbulance(),
                  buildPriceDetails(),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildLocation(ambulanceBooking.source.areaDetails, "From"),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  buildLocation(ambulanceBooking.destination.areaDetails, "To"),
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
                iconData: Icons.keyboard_backspace, text: '',
              ),
              SizedBox(
                width: 18.0,
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Request Trip",
                  onTap: () {
                    BlocProvider.of<AmbulanceBookingBloc>(context).add(
                        AmbulanceelectedEvent(
                            ambulanceType: selectedAmbulanceType));
                  }, iconData: Icons.request_page,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  late AmbulanceTypes selectedAmbulanceType;

  Widget buildAmbulance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ambulanceTypes.map((val) => GestureDetector(
            onTap: () {
              setState(() {
                selectedAmbulanceType = val;
              });
            },
            child: Opacity(
              opacity: val == selectedAmbulanceType ? 1.0 : 0.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        "images/Ambulance.jpg",
                        height: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      val.toString().replaceFirst("AmbulanceType.", ""),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
    );
  }

  Widget buildPriceDetails() {
    return Column(
      children: <Widget>[
        Divider(),
        SizedBox(
          height: 14.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildIconText("21 km", Icons.directions),
            buildIconText("1-3", Icons.person_outline),
            buildIconText("\$150", Icons.monetization_on),
          ],
        ),
        SizedBox(
          height: 14.0,
        ),
        Divider()
      ],
    );
  }

  Widget buildIconText(String text, IconData iconData) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 22.0,
          color: Colors.black,
        ),
        Text(
          " $text",
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }

  Widget buildLocation(String area, String label) {
    return Row(
      children: <Widget>[
        Text(
          "•",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$label",
                style: TextStyle(fontSize: 14.0, color: Colors.black38),
              ),
              Text(
                "$area",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        )
      ],
    );
  }
}

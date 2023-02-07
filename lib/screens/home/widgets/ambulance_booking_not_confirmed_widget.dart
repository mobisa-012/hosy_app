import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_driver.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_cancellation_dialog.dart';
import 'package:hosy/screens/home/widgets/rounded_button.dart';


class AmbulanceBookingNotConfirmedWidget extends StatefulWidget {
  const AmbulanceBookingNotConfirmedWidget({super.key});

  @override
  AmbulanceBookingNotConfirmedWidgetState createState() =>
      AmbulanceBookingNotConfirmedWidgetState();
}

class AmbulanceBookingNotConfirmedWidgetState
    extends State<AmbulanceBookingNotConfirmedWidget> {
  late AmbulanceBooking booking;
  late AmbulanceDriver driver;

  @override
  void initState() {
    super.initState();
    booking = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as AmbulanceNotConfirmedState)
        .booking;
    driver = (BlocProvider.of<AmbulanceBookingBloc>(context).state
            as AmbulanceNotConfirmedState)
        .driver;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildDriver(),
                const SizedBox(
                  height: 12.0,
                ),
                buildPriceDetails(),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      size: 22.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                        child: Text(
                      "Change Pickup Location",
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                    Text(
                      "Edit",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              RoundedButton(
                onTap: () {},
                iconData: Icons.call, text: '',
              ),
              const SizedBox(
                width: 24.0,
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Cancel Booking",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            const AmbulanceBookingCancellationDialog());
                  }, iconData: Icons.clear,
                ),
              )
            ],
          ),
        ],
      ),
    );
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              driver.ambulanceDetails,
              style: Theme.of(context).textTheme.titleSmall,
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPriceDetails() {
    return Column(
      children: <Widget>[
        const Divider(),
        const SizedBox(
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
        const SizedBox(
          height: 14.0,
        ),
        const Divider()
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
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}

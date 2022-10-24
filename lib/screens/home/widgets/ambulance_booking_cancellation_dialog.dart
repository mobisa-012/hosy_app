import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_event.dart';

class AmbulanceBookingCancellationDialog extends StatelessWidget {
  const AmbulanceBookingCancellationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cancel Ride"),
      content: const Text("Do you want to cancel ride?"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text(
            "Ok",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            BlocProvider.of<AmbulanceBookingBloc>(context)
                .add(AmbulanceBookingCancelEvent());
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

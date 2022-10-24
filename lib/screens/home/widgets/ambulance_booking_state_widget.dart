import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_cancellation_dialog.dart';
import 'package:hosy/screens/home/widgets/dashed_line.dart';


class AmbulanceBookingStateWidget extends StatelessWidget {
  const AmbulanceBookingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AmbulanceBookingBloc>(context),
      builder: (context, state) {
        int selectedTab = 1;
        Object? currentState = state;
        String title = "";
        if (state is AmbulanceBookingLoadingState) {
          currentState = state.state;
        }
        switch (currentState.runtimeType) {
          case DetailsNotFilledState:
            selectedTab = 1;
            title = "New Destination";
            break;
          case AmbulanceNotSelectedState:
            selectedTab = 2;
            title = "Choose Ride";
            break;
          case PaymentNotInitializedState:
            selectedTab = 3;
            title = "Payment Method";
            break;
          case AmbulanceNotConfirmedState:
            selectedTab = 4;
            title = "Ride Info";
            break;
        }
        return Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const AmbulanceBookingCancellationDialog());
                      },
                      color: Colors.white),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(children: [
                buildTab(context, "1", selectedTab >= 1),
                Expanded(
                  child: DashedLine(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                buildTab(context, "2", selectedTab >= 2),
                Expanded(
                  child: DashedLine(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                buildTab(context, "3", selectedTab >= 3),
                Expanded(
                  child: DashedLine(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                buildTab(context, "4", selectedTab >= 4),
              ]),
              const SizedBox(
                height: 12.0,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildTab(BuildContext context, String val, bool enabled) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          val,
          style: Theme.of(context).textTheme.headline5?.copyWith(
              color: enabled ? Colors.black : Colors.white, fontSize: 15),
        ));
  }
}

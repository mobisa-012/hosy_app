import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_bloc.dart';
import 'package:hosy/screens/home/bloc/ambulance_booking_state.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_details_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_not_confirmed_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_payments_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_state_widget.dart';
import 'package:hosy/screens/home/widgets/ambulance_booking_taxis_widget.dart';
import 'package:hosy/screens/home/widgets/loading_shimmer.dart';

class AmbulanceBookingHomeWidget extends StatefulWidget {
  @override
  AmbulanceBookingHomeWidgetState createState() =>
      AmbulanceBookingHomeWidgetState();
}

class AmbulanceBookingHomeWidgetState extends State<AmbulanceBookingHomeWidget>
    with TickerProviderStateMixin<AmbulanceBookingHomeWidget> {
  late AnimationController animationController;
  late Animation animation;
  
  @override
  void initState() {
    super.initState();
    print("Home Build ");
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
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
    double requiredHeight = MediaQuery.of(context).size.height * 2.5 / 3;
    return BlocListener<AmbulanceBookingBloc, AmbulanceBookingState>(
      listener: (context, state) async {
        if (state is AmbulanceBookingCancelledState)
          await animationController.reverse(from: 1.0);
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              height: requiredHeight * animation.value,
              child: child,
            );
          },
          child: SingleChildScrollView(
            child: Container(
              height: requiredHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                      child: AmbulanceBookingStateWidget()),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36.0),
                            topRight: Radius.circular(36.0)),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.0),
                          height: MediaQuery.of(context).size.height * 1 / 1.6,
                          margin: EdgeInsets.only(bottom: 24.0),
                          child: BlocBuilder<AmbulanceBookingBloc,
                              AmbulanceBookingState>(
                            builder: (context, currentState) {
                              switch (currentState.runtimeType) {
                                case AmbulanceBookingLoadingState:
                                  return LoadingShimmer();
                                case DetailsNotFilledState:
                                  return AmbulanceBookingDetailsWidget();
                                case AmbulanceNotSelectedState:
                                  return AmbulanceBookingAmbulanceWidget();
                                case PaymentNotInitializedState:
                                  return AmbulanceBookingPaymentsWidget();
                                case AmbulanceNotConfirmedState:
                                  return AmbulanceBookingNotConfirmedWidget();
                                default:
                                  return Center(
                                    child: Text("Not Initialized"),
                                  );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

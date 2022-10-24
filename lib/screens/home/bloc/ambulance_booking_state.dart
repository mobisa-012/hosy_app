import 'package:equatable/equatable.dart';
import 'package:hosy/core/services/ambulance.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_driver.dart';
import 'package:hosy/core/services/payment_method.dart';

abstract class AmbulanceBookingState extends Equatable {
  const AmbulanceBookingState();
}

class AmbulanceBookingNotInitializedState extends AmbulanceBookingState {
  const AmbulanceBookingNotInitializedState();
  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

class AmbulanceBookingNotSelectedState extends AmbulanceBookingState {
  final List<Ambulance> ambulanceAvailable;

  const AmbulanceBookingNotSelectedState({required this.ambulanceAvailable});

  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

class DetailsNotFilledState extends AmbulanceBookingState {
  final AmbulanceBooking booking;

  const DetailsNotFilledState(
    {required this.booking}
  );
  @override
  List<Object> get props => [booking];
}

class AmbulanceNotSelectedState extends AmbulanceBookingState {
  final AmbulanceBooking booking;

  const AmbulanceNotSelectedState({required this.booking});

  @override
  List<Object> get props => [booking];
}

class PaymentNotInitializedState extends AmbulanceBookingState {
  final AmbulanceBooking booking;
  final List<PaymentMethod> methodsAvaiable;

  const PaymentNotInitializedState({
    required this.booking,
    required this.methodsAvaiable,
  });

  @override
  List<Object> get props => [booking];
}

class AmbulanceNotConfirmedState extends AmbulanceBookingState {
  final AmbulanceDriver driver;
  final AmbulanceBooking booking;

  const AmbulanceNotConfirmedState({required this.driver, required this.booking});

  @override
  List<Object> get props => [driver, booking];
}

class AmbulanceConfirmedState extends AmbulanceBookingState {
  final AmbulanceDriver driver;
  final AmbulanceBooking booking;

  const AmbulanceConfirmedState({required this.driver, required this.booking});

  @override
  List<Object> get props => [driver, booking];
}

class AmbulanceBookingCancelledState extends AmbulanceBookingState {
  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

class AmbulanceBookingLoadingState extends AmbulanceBookingState {
  final AmbulanceBookingState state;

  const AmbulanceBookingLoadingState({required this.state});
  @override
  List<Object> get props => [state];
}

class AmbulanceBookingConfirmedState extends AmbulanceBookingState {
  final AmbulanceDriver driver;
  final AmbulanceBooking booking;

  const AmbulanceBookingConfirmedState({required this.driver, required this.booking});
  @override
  List<Object> get props => [driver];
}

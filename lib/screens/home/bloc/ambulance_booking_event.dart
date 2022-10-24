// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/core/services/payment_method.dart';

abstract class AmbulanceBookingEvent extends Equatable {
  const AmbulanceBookingEvent();
}

class AmbulanceBookingStartEvent extends AmbulanceBookingEvent {
  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

class DestinationSelectedEvent extends AmbulanceBookingEvent {
  final LatLng destination;

  const DestinationSelectedEvent({required this.destination});

  @override
  List<Object> get props => [destination];
}

class DetailsSubmittedEvent extends AmbulanceBookingEvent {
  final GoogleLocation source;
  final GoogleLocation destination;
  final int noOfPersons;
  final DateTime bookingTime;
  late AmbulanceTypes ambulanceType;
  late String id;
  late PaymentMethod paymentMethod;
  late double estimatedPrice;
  late String promoApplied;

  DetailsSubmittedEvent(
      {required this.source,
      required this.destination,
      required this.noOfPersons,
      required this.bookingTime});

  @override
  List<Object> get props => [source, destination, noOfPersons, bookingTime];
}

class AmbulanceSelectedEvent extends AmbulanceBookingEvent {
  final AmbulanceTypes ambulanceType;

  const AmbulanceSelectedEvent({required this.ambulanceType});

  @override
  List<Object> get props => [ambulanceType];
}

class PaymentMadeEvent extends AmbulanceBookingEvent {
  final PaymentMethod paymentMethod;

  const PaymentMadeEvent({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}

class BackPressedEvent extends AmbulanceBookingEvent {
  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

class AmbulanceBookingCancelEvent extends AmbulanceBookingEvent {
  @override
  List<Object?> get props {
    throw UnimplementedError();
  }
}

import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/core/services/payment_method.dart';

class AmbulanceBooking {
  final String id;
  final GoogleLocation source;
  final GoogleLocation destination;
  final int noOfPersons;
  final DateTime bookingTime;
  final AmbulanceTypes ambulanceType;
  final double estimatedPrice;
  final PaymentMethod paymentMethod;
  final String promoApplied;

  AmbulanceBooking(
      this.id,
      this.source,
      this.destination,
      this.noOfPersons,
      this.bookingTime,
      this.ambulanceType,
      this.estimatedPrice,
      this.paymentMethod,
      this.promoApplied);

  AmbulanceBooking.named(
    this.id,
    this.source,
    this.destination,
    this.noOfPersons,
    this.bookingTime,
    this.ambulanceType,
    this.estimatedPrice,
    this.paymentMethod,
    this.promoApplied,
  );

  AmbulanceBooking copyWith(AmbulanceBooking booking) {
    return AmbulanceBooking.named(
        id,
        source,
        destination,
        noOfPersons,
        bookingTime,
        ambulanceType,
        estimatedPrice,
        paymentMethod,
        promoApplied);
  }
}

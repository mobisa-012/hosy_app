import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/core/services/payment_method.dart';



class AmbulanceBookingStorage {
  static late AmbulanceBooking ambulanceBooking;

   static Future<void> open() async {
    ambulanceBooking = AmbulanceBooking.named(
      '2',
      ambulanceBooking.source,
      ambulanceBooking.destination,
      5,
      ambulanceBooking.bookingTime,
      AmbulanceTypes.premium,
      6000.50,
      const PaymentMethod('5', 'Pay via M-pesa', PathConstants.payment, 'Lipa na M-pesa and get a 10% discount'),
      'Get 30% off if you\'re within Embakasi'
    );
  }

  static Future<AmbulanceBooking> addDetails(
      AmbulanceBooking ambulanceBooking) async {
    ambulanceBooking = ambulanceBooking.copyWith(ambulanceBooking);
    return ambulanceBooking;
  }

  static Future<AmbulanceBooking> getAmbulanceBooking() async {
    return ambulanceBooking;
  }
}

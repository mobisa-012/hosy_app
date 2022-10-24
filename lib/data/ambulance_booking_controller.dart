// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/ambulance.dart';
import 'package:hosy/core/services/ambulance_booking.dart';
import 'package:hosy/core/services/ambulance_driver.dart';
import 'package:hosy/core/services/ambulance_type.dart';
import 'package:hosy/core/services/google_location.dart';
import 'package:hosy/data/location_controller.dart';

class AmbulanceBookingController {
  static Future<double> getPrice(AmbulanceBooking booking) async {
    return 200;
  }

  static Future<AmbulanceDriver> getAmbulanceDriver(
      AmbulanceBooking booking) async {
    return AmbulanceDriver.named(
        '82', 'Mobisa', PathConstants.profile1, 3.5, 'KBN 562R');
  }

  static Future<List<Ambulance>> getAmbulanceAvailable() async {
    GoogleLocation location = await LocationController.getCurrentLocation();
    const double maxRadius = 200 / 111300;
    Random random = Random();
    List<Ambulance> ambulance = List<Ambulance>.generate(10, (index) {
      double u = random.nextDouble();
      double v = random.nextDouble();
      double w = random.nextDouble();
      double t = random.nextDouble();
      double x1 = random.nextDouble();
      double y1 = random.nextDouble();
      x1 = x1 / cos(y1);
      LatLng oldPos = location.position;
      return Ambulance.named(
        'index',
        'Ambulance $index',
        true,
        'KBN 567Y',
        AmbulanceTypes.premium,
        LatLng(x1 + oldPos.latitude, y1 + oldPos.longitude),
      );
    });
    return ambulance;
  }
}

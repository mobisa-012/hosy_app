import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/ambulance.dart';
import 'package:hosy/core/services/ambulance_type.dart';


class AmbulanceController {
  static Future<List<Ambulance>> getAmbulance() async {
    return [
       const Ambulance.named(
        '0', 
        'Standard', 
        false, 
        'KDG 332G', 
        AmbulanceTypes.standard, 
        LatLng(10.42796133580664, -110.085749655962)),
      const Ambulance.named(
        '0', 
        'Premium', 
        false, 
        'KCD 862G', 
        AmbulanceTypes.premium, 
        LatLng(25.42796133580664, -90.085749655962)),
      const Ambulance.named(
        '0', 
        'Platinum', 
        false, 
        'KBV 338G', 
        AmbulanceTypes.platinum, 
        LatLng(35.42796133580664, -100.085749655962)),
      const Ambulance.named(
        '0', 
        'Standard', 
        false, 
        'KAR 332G', 
        AmbulanceTypes.standard, 
        LatLng(85.42796133580664, -100.085749655962)),
    ];
  }
}

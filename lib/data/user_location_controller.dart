import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosy/core/services/user_location.dart';
import 'package:location/location.dart';

class UserLocationController {
  static Future<LatLng?> getCurrentLocation() async {
    Location location = Location();
    bool check = (await location.hasPermission()) as bool;
    if(!check) {
      bool result = (await location.requestPermission()) as bool;
      if (result) {
        LocationData position = await location.getLocation();
        return LatLng(position.latitude!, position.longitude! );
        
        //parameter only accepted double and no null 
        //hence the null sign to force use of non-null
      }
    }
    return null;
  }


  static Future<List<UserLocation>> getSavedLocations() async {
    return [
      UserLocation.named('Home', UserLocationType.home, const LatLng(8, 10), 5),
      UserLocation.named(
          'KICC', UserLocationType.office, const LatLng(0, 0), 10)
    ];
  }
}

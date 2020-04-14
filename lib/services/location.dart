import 'package:geolocator/geolocator.dart';

class Location {
  //5.2
  double latitude;
  double longitude;

  // 5.3 return Future<void> to enable getLocation() in loading_Screen to await as well!!
  Future<void> getCurrentLocation() async {
    // 4.2 - getLocation() might fail, as user denies permission, gps not available, location unknown, etc.
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // 1.3
      // 5.4
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

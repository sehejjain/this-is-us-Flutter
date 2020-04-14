import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:thisisus/models/LocationModel.dart';

import 'networking.dart';

class VolLocBrain {
  var locationsData;
  List<VolLoc> _listLoc = [];

  List<VolLoc> getListLoc() => _listLoc;

  Future<dynamic> getLocations() async {
    var querySnapshot =
        await Firestore.instance.collection("VolLocs").getDocuments();
    var list = querySnapshot.documents;
    for (var loc in list) {
      var locationn = VolLoc(
        creator: loc.data["creator"],
        name: loc.data["name"],
        contactPhone: loc.data["contact_phone"],
        contactEmail: loc.data["contact_email"],
        dateStart: DateTime.parse((loc.data["dateStart"]).toDate().toString()),
        dateEnd: DateTime.parse((loc.data["dateEnd"]).toDate().toString()),
        location: loc.data["location"],
        desc: loc.data["desc"],
        dateCreated:
            DateTime.parse((loc.data["dateCreated"]).toDate().toString()),
      );
      _listLoc.add(locationn);
    }
    print(_listLoc);
    return list;
  }

  String apiKey = 'AIzaSyCYFdGWM2mkC3B45CGn3YDXDl979cMt81c';

  Future<dynamic> getCityData(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('https://maps.googleapis'
        '.com/maps/api/geocode/json?address=$cityName&key=$apiKey');
    var locData = await networkHelper.getData();
    print(locData);
    return locData;
  }

//  List<VolLoc> getList(String cityName) {
////    for (var loc in locationsData) {
////      VolLoc(
////          creator: loc.data["creator"],
////          name: loc.data["name"],
////          contact_phone: loc.data["contact_phone"],
////          contact_email: loc.data["contact_email"],
////          dateStart:
////              DateTime.parse((loc.data["dateStart"]).toDate().toString()),
////          dateEnd: DateTime.parse((loc.data["dateEnd"]).toDate().toString()),
////          location: loc.data["location"],
////          desc: loc.data["desc"], dateCreated: DateTime.parse((loc
////          .data["dateCreated"]).toDate().toString()), q);
//    }
//    return null;
//  }

  Future<String> getCityName(GeoPoint a) async {
    final coordinates = new Coordinates(a.latitude, a.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first.locality;
  }
}

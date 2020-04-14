import 'package:cloud_firestore/cloud_firestore.dart';

class VolLoc {
  String creator;
  String name;
  GeoPoint location;

  String contact_email;
  String contact_phone;
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateCreated;
  String desc;

  VolLoc(
      {this.creator,
      this.name,
      this.contact_email,
      this.location,
      this.contact_phone,
      this.dateStart,
      this.dateEnd,
      this.dateCreated,
      this.desc});

  Map<String, dynamic> toJson() => {
        'creator': creator,
        'name': name,
        'contact_email': contact_email,
        'contact_phone': contact_phone,
        'location': location,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'dateCreated': dateCreated,
        'desc': desc,
      };
}

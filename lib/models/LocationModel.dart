import 'package:cloud_firestore/cloud_firestore.dart';

class VolLoc {
  String creator;
  String name;
  GeoPoint location;

  String contactEmail;
  String contactPhone;
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateCreated;
  String desc;

  VolLoc(
      {this.creator,
      this.name,
        this.contactEmail,
      this.location,
        this.contactPhone,
      this.dateStart,
      this.dateEnd,
      this.dateCreated,
      this.desc});

  Map<String, dynamic> toJson() => {
        'creator': creator,
        'name': name,
    'contact_email': contactEmail,
    'contact_phone': contactPhone,
        'location': location,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'dateCreated': dateCreated,
        'desc': desc,
      };
}

import 'dart:io';

class OrgProfile {
  final String id;
  String name;
  File image;
  String phone;
  String desc;

  OrgProfile({this.id, this.name, this.image, this.desc});

  OrgProfile.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        image = data['image'],
        desc = data["desc"],
        phone = data["phone"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
//TODO: Yet to be implemented

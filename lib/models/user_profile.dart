class UserProfile {
  final String id;
  String fullName;
  String phone;
  UserProfile({this.id, this.fullName});
  UserProfile.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        phone = data["phone"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
    };
  }
}
//TODO: Yet to be implemented

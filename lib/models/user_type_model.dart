class UserType {
  int type;

  UserType(this.type); // 1 for Org, 0 for Individual
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}

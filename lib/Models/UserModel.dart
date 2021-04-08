class UserModel {
  String name;
  String bio;

  UserModel({ this.name, this.bio});

  Map<String, dynamic> toMap() {
    return { "name": name, "bio": bio};
  }
}

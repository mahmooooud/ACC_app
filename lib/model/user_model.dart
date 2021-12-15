class UserModel {
  String userId, email, name;

  UserModel({ this.userId, this.email,  this.name});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }
}

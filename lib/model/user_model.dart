class UserModel {
  String userId, email, name;
  List <CategoryLocation> categoryData;
  UserModel({ this.userId, this.email, this.name, this.categoryData});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    categoryData = new List<CategoryLocation>();
    map['categoryData'].forEach((v) {
      categoryData.add(new CategoryLocation.fromJson(v));
    });
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      "categoryData" : categoryData.map((e) => e.toJson()).toList()
    };
  }
}

class CategoryLocation {
  String name, lat, long;

  CategoryLocation({ this.name, this.lat,  this.long});

  CategoryLocation.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    lat = map['lat'];
    long = map['long'];
  }

  toJson() {
    return {
      'name': name,
      'lat': lat,
      'long': long,
    };
  }
}
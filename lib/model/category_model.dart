
class CategoryModel {
  String name = "", image = "", sound = "", frequency = "", userId = "",lang = "";

  CategoryModel({ this.name, this.image, this.sound, this.frequency, this.userId, this.lang});

  CategoryModel.fromJson(Map<dynamic, dynamic> map){
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
    sound = map['sound'];
    frequency = map['frequency'];
    userId = map['userId'];
    lang = map['image_ar'];

  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'sound': sound,
      'frequency': frequency,
      'userId': userId,
      'lang': lang,

    };
  }
}
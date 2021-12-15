
class HomeModel {
  String name = "", imageEn = "", lat = "", long = "", imageAr = "", frequency = "", soundAr = "", soundEn = "";

  HomeModel({ this.name, this.imageEn, this.lat, this.long, this.imageAr,this.frequency,this.soundAr,this.soundEn});

  HomeModel.fromJson(Map<dynamic, dynamic> map){
    if (map == null) {
      return;
    }
    name = map['name'];
    imageEn = map['image_en'];
    long = map['long'];
    lat = map['lat'];
    imageAr = map['image_ar'];
    frequency = map['frequency'];
    soundAr = map['sound_ar'];
    soundEn = map['sound_en'];
  }

  toJson() {
    return {
      'name': name,
      'image_ar': imageAr,
      'image_en': imageEn,
      'long': long,
      'lat': lat,
      'frequency': frequency,
      'sound_ar': soundAr,
      'sound_en': soundEn
    };
  }
}

import 'dart:convert';

import 'package:acc_app/constants.dart';
import 'package:acc_app/core/service/home_service.dart';
import 'package:acc_app/model/category_model.dart';
import 'package:acc_app/model/home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'dart:math' as math;

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  String _collection = "";
  String get collection => _collection;

  List<HomeModel> get homeModel => _homeModel;
  List<HomeModel> _homeModel = [];
  List<HomeModel> homeModelClone = [];
  HomeViewModel() {
    getCategory("category");
  }

  getCategory(String collection) async {
    _loading.value = true;
    _homeModel = [];
    HomeService().getCategory(collection).then((value) {
      for (int i = 0; i < value.length; i++) {
          _homeModel.add(HomeModel(
              imageAr: value[i].get('image_ar'),
              imageEn: value[i].get('image_en'),
              name: value[i].get('name'),
              lat: value[i].get('lat'),
              long: value[i].get('long'),
              frequency: value[i].get('frequency'),
              soundEn: value[i].get('sound_en'),
              soundAr: value[i].get('sound_ar'),
          ));
        _loading.value = false;
      }
      homeModelClone = _homeModel;
      checkDistance();
      update();
    });
  }
  var homeModelTemp;
  checkDistance(){
    for(int i = 0; i < _homeModel.length; i++){
        if(calculateDistance(
          lat1: double.parse("${StaticVars.currentLat}"),
          lon1: double.parse("${StaticVars.currentLong}"),
          lat2: double.parse('${_homeModel[i].lat}'),
          lon2: double.parse("${_homeModel[i].long}")
        ) < 0.05 && int.parse("${_homeModel[i].frequency}") > 3){
          homeModelTemp = _homeModel[i];
          _homeModel.removeAt(i);
          _homeModel.insert(2, homeModelTemp);
        }
    }
    update();
  }
  updateLocation(int index,String frequency){
    _loading.value = true;

    CollectionReference users = FirebaseFirestore.instance.collection('category');
    FirebaseFirestore.instance.collection('category').get().then((QuerySnapshot querySnapshot) {
      print("querySnapshot ${querySnapshot.docs[index].id}");
      print("querySnapshot ${StaticVars.currentLat}");
      print("querySnapshot ${StaticVars.currentLong}");
      users.doc(
          querySnapshot.docs[index].id).update(
          {'lat': "${StaticVars.currentLat}" , "long" : "${StaticVars.currentLong}",'frequency': "${int.parse(frequency) + 1}"}

      ).then(

              (value) => print("'full_name' & 'age' merged with existing data!")
      ).catchError((error) => print("Failed to merge data: $error"));
      getCategory("category");
      XsProgressHud.hide();
    });
    print("users ${users.id}");
  }
  updateCollection(String collection){
    StaticVars.collection = collection;
    update();
  }

  degreesToRadians(degrees) {
    return degrees * math.pi / 180;
  }
  calculateDistance({lat1, lon1, lat2, lon2}) {
    var lat_pure = lat2;
    var lan_pure = lon2;

    var earthRadiusKm = 6371;

    var dLat = degreesToRadians(lat2 - lat1);
    var dLon = degreesToRadians(lon2 - lon1);

    lat1 = degreesToRadians(lat1);
    lat2 = degreesToRadians(lat2);

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(dLon / 2) *
            math.sin(dLon / 2) *
            math.cos(lat1) *
            math.cos(lat2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    print('distnace is :- ${earthRadiusKm * c}');


    return earthRadiusKm * c;
  }
}

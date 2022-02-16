import 'dart:convert';

import 'package:acc_app/constants.dart';
import 'package:acc_app/core/service/home_service.dart';
import 'package:acc_app/model/category_model.dart';
import 'package:acc_app/model/home_model.dart';
import 'package:acc_app/model/user_model.dart';
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

  List categoryName = [{}];
  List categoryIndex = [{}];
  UserModel userModel;
  List<String> userIds = [];
  List<CategoryLocation> categoryLocation = [];
  HomeViewModel() {
    getUserData("Users");
  }

  getCategory(String collection) async {
    _loading.value = true;
    _homeModel = [];
    HomeService().getCategory(collection).then((value) {
      for (int i = 0; i < value.length; i++) {
        print("categoryLocationlat ${categoryLocation[i].lat}");
        categoryName.add("${value[i].get('name')}");
        categoryIndex.add(i);
          _homeModel.add(HomeModel(
              imageAr: value[i].get('image_ar'),
              imageEn: value[i].get('image_en'),
              name: value[i].get('name'),
              lat: value[i].get('lat'),
              long: value[i].get('long'),
              frequency: value[i].get('frequency'),
              soundEn: value[i].get('sound_en'),
              soundAr: value[i].get('sound_ar'),
              distance: calculateDistance(
                  lat1: double.parse("${StaticVars.currentLat}"),
                  lon1: double.parse("${StaticVars.currentLong}"),
                  lat2: value[i].get('lat') == ""? 0.0 : double.parse(categoryLocation[i].lat),
                  lon2: value[i].get('long') == ""? 0.0 : double.parse(categoryLocation[i].long)
              ).toString()
          ));
        _loading.value = false;
      }
      print("dataLocation ${categoryName}");
      print("dataLocation ${categoryIndex}");
      _homeModel.sort((first,second) =>  double.parse(first.distance).compareTo(double.parse(second.distance)));
      homeModelClone = _homeModel;
      // checkDistance();
      update();
    });
  }
  getUserData(String collection) async {
    _loading.value = true;
    userIds = [];
    categoryLocation = [];
    HomeService().getCategory(collection).then((value) {
      for (int i = 0; i < value.length; i++) {
        print("userModel ${value.length}");
        userIds.add(value[i]['userId']);
        if(value[i]['userId'] == StaticVars.userId){
          print("userModel ${value[i]['name']}");
          print("userModel ${value[i]['categoryData'].length}");
          for(int j = 0;j<value[i]['categoryData'].length;j++){
            categoryLocation.add(CategoryLocation(
              name: value[i]['categoryData'][j]['name'],
              lat: value[i]['categoryData'][j]['lat'],
              long:value[i]['categoryData'][j]['long'],
            ),);
          }
          userModel = UserModel(
              categoryData: categoryLocation,
              name: value[i]['name'],
              email: value[i]['email'],
              userId: value[i]['userId']
          );
        }
        // checkDistance();
        _loading.value = false;
      }
      print("userModel ${userModel}");
      getCategory("category");
      update();
    });
  }
  var homeModelTemp;
  checkDistance(){
    for(int i = 0; i < userModel.categoryData.length; i++){
      print("Distance ${calculateDistance(
          lat1: double.parse("${StaticVars.currentLat}"),
          lon1: double.parse("${StaticVars.currentLong}"),
          lat2: double.parse('${userModel.categoryData[i].lat}'),
          lon2: double.parse("${userModel.categoryData[i].long}")
      )} For ${_homeModel[i].name}\n");
        if(calculateDistance(
          lat1: double.parse("${StaticVars.currentLat}"),
          lon1: double.parse("${StaticVars.currentLong}"),
          lat2: double.parse('${userModel.categoryData[i].lat}'),
          lon2: double.parse("${userModel.categoryData[i].long}")
       )){
          // homeModelTemp = _homeModel[i];
          // _homeModel.removeAt(i);
          // _homeModel.insert(0, homeModelTemp);
        }
    }
    update();
  }
  // updateLocation(String category,String frequency){
  //   _loading.value = true;
  //   int index = 0;
  //   CollectionReference users = FirebaseFirestore.instance.collection('category');
  //   FirebaseFirestore.instance.collection('category').get().then((QuerySnapshot querySnapshot) {
  //
  //     print("querySnapshot ${StaticVars.currentLat}");
  //     print("querySnapshot ${StaticVars.currentLong}");
  //     for(int i = 0; i < categoryName.length;i++){
  //       print("category ${category}");
  //       print("category ${categoryName[i]}");
  //       print("category ${categoryName[i] == category}");
  //       if(categoryName[i] == category){
  //         index = categoryIndex[i];
  //         break;
  //       }
  //     }
  //     print(index);
  //     print("querySnapshot ${querySnapshot.docs[index].id}");
  //     print("querySnapshot ${querySnapshot.docs[index].data()}");
  //     users.doc(
  //         querySnapshot.docs[index].id).update(
  //         {'lat': "${StaticVars.currentLat}" , "long" : "${StaticVars.currentLong}",'frequency': "${int.parse(frequency) + 1}"}
  //
  //     ).then((value) => print("'full_name' & 'age' merged with existing data!")
  //     ).catchError((error) => print("Failed to merge data: $error"));
  //     getCategory("category");
  //     XsProgressHud.hide();
  //   });
  //   print("users ${users.id}");
  // }
  updateLocation(String category,String frequency){
    _loading.value = true;
    int index = 0;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    for(int i = 0;i<StaticVars.categoryLocation.length;i++){
      if(StaticVars.categoryLocation[i].name == category){
        StaticVars.categoryLocation[i].lat = StaticVars.currentLat;
        StaticVars.categoryLocation[i].long = StaticVars.currentLat;
      }else{
        StaticVars.categoryLocation[i].lat = categoryLocation[i].lat;
        StaticVars.categoryLocation[i].long = categoryLocation[i].long;
      }

    }

    for(int i = 0;i<userIds.length;i++){
      if(userIds[i]  == StaticVars.userId){
        index = i;
      }
    }
    FirebaseFirestore.instance.collection('Users').get().then((QuerySnapshot querySnapshot) {

      print("querySnapshot ${StaticVars.currentLat}");
      print("querySnapshot ${StaticVars.currentLong}");
      print(index);
      print("querySnapshot ${querySnapshot.docs[index].id}");
      print("querySnapshot ${querySnapshot.docs[index].data()}");
      users.doc(
          querySnapshot.docs[index].id).update(
          {'categoryData': StaticVars.categoryLocation.map((e) => e.toJson()).toList()}

      ).then((value) => print("'full_name' & 'age' merged with existing data!")
      ).catchError((error) => print("Failed to merge data: $error"));
      getUserData("Users");
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

    // print('distnace is :- ${earthRadiusKm * c}');


    return earthRadiusKm * c;
  }
}

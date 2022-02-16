import 'package:acc_app/model/user_model.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);


class StaticVars{
  static String userId = "";
  static String langSelected = "";
  static String collection = "";
  static String currentLat = "";
  static String currentLong = "";

  static List <CategoryLocation> categoryLocation = [
    CategoryLocation(lat: "0.0",long: "0.0",name: "number"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "alphabet"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "object"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "story"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "answers"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "want"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "feeling"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "greeting"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "like"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "dont"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "affection"),
    CategoryLocation(lat: "0.0",long: "0.0",name: "social")
  ];
}
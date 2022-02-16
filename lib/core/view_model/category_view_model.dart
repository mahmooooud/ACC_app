import 'dart:io';
import 'package:acc_app/constants.dart';
import 'package:acc_app/core/service/home_service.dart';
import 'package:acc_app/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:xs_progress_hud/xs_progress_hud.dart';
class CategoryViewModel extends GetxController {

  String downloadImageURL = "";
  String downloadSoundURL = "";



  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  FileType get pickingType => _pickingType;
  FileType _pickingType = FileType.any;

  List<PlatformFile> get filePath => _filePath;
  List<PlatformFile> _filePath;
  List<PlatformFile> _filePathClone;



  List<PlatformFile> get imagePath => _imagePath;
  List<PlatformFile> _imagePath;
  List<PlatformFile> _imagePathClone;



  String get extension => _extension;
  String _extension;

  List<CategoryModel> get categoryModel => _categoryModel;
  List<CategoryModel> _categoryModel = [];

  CategoryViewModel() {
    getCategory("${StaticVars.collection}");
  }

  getCategory(String collection) async {
    _loading.value = true;
    _categoryModel = [];
    print("UserId ${StaticVars.userId}");
    print("UserId ${StaticVars.collection}");
   HomeService().getCategory(collection).then((value) {
     print("UserId ${value.length}");
       for (int i = 0; i < value.length; i++) {
         if(StaticVars.collection == "alphabet" || StaticVars.collection == "number"){
             _categoryModel.add(CategoryModel(
               image: value[i].get('image'),
               name: value[i].get('name'),
               sound: value[i].get('sound'),
               frequency: value[i].get('frequency'),
               userId: value[i].get('userId'),
               lang: value[i].get('lang'),
             ));
         }else{
           if(value[i].get("userId") == StaticVars.userId && value[i].get("lang") == StaticVars.langSelected){
             _categoryModel.add(CategoryModel(
               image: value[i].get('image'),
               name: value[i].get('name'),
               sound: value[i].get('sound'),
               frequency: value[i].get('frequency'),
               userId: value[i].get('userId'),
               lang: value[i].get('lang'),
             ));
           }
         }
        _loading.value = false;
      }
       print("_categoryModel ${_categoryModel}");
       _categoryModel.sort((first,second) =>  int.parse(second.frequency).compareTo(int.parse(first.frequency)));
       update();
    });
  }

  updateData(int index,String frequency){
    _loading.value = true;
    CollectionReference users = FirebaseFirestore.instance.collection('${StaticVars.collection}');
    print("frequency ${frequency}");
    print("frequency ${frequency}");
    FirebaseFirestore.instance.collection('${StaticVars.collection}').get().then((QuerySnapshot querySnapshot) {
      users.doc(
        querySnapshot.docs[index].id).update(
          {'frequency': "${int.parse(frequency) + 1}"}
        ).then(
          (value) => print("'full_name' & 'age' merged with existing data!")
        ).catchError((error) => print("Failed to merge data: $error"));
      getCategory("${StaticVars.collection}");
      XsProgressHud.hide();
    });
    print("users ${users.id}");

  }

  void pickImage(StateSetter state) async {
    try {
      _imagePathClone = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))?.files;
      state((){
        _imagePath = _imagePathClone;
      });
      print("_paths ${_imagePath}");
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print("error:  ${e.toString()}");
    }

  }
  void pickFiles(StateSetter state) async {
    try {
      _filePathClone = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))?.files;
      state((){
        _filePath = _filePathClone;
      });
      print("_paths ${_filePath}");
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print("error:  ${e.toString()}");
    }
  }
  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("sounds").child("${filePath.split("/")[filePath.split("/").length-1]}")
          .putFile(file);
      downloadSoundURL = await firebase_storage.FirebaseStorage.instance
          .ref('sounds').child("${filePath.split("/")[filePath.split("/").length-1]}")
          .getDownloadURL();
      print("FileUrl ${downloadSoundURL}");
    } catch (e) {
      // e.g, e.code == 'canceled'
      print("Error ${e}");
    }
  }
  Future<void> uploadImage(String filePath) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("images").child("${filePath.split("/")[filePath.split("/").length-1]}")
          .putFile(file);
      downloadImageURL = await firebase_storage.FirebaseStorage.instance
          .ref('images').child("${filePath.split("/")[filePath.split("/").length-1]}")
          .getDownloadURL();
      print("FileUrl ${downloadImageURL}");
    } catch (e) {
      // e.g, e.code == 'canceled'
      print("Error ${e}");
    }
  }

  Future<void> addCategory()async{
    CollectionReference category = FirebaseFirestore.instance.collection('${StaticVars.collection}');
    return category
        .add({
      'name': "Add By User",
      'image': "${downloadImageURL}",
      'sound': "${downloadSoundURL}",
      'frequency': "0",
      'userId': "${StaticVars.userId}",
      'lang': "${StaticVars.langSelected}",

    })
      .then((value){
        print("User Added");
        XsProgressHud.hide();

        clearData();
        getCategory("${StaticVars.collection}");
      }).catchError((error) => print("Failed to add user: $error"));
  }
  void clearData(){
    downloadImageURL = "";
    downloadSoundURL = "";


    _filePath = [];
    _filePathClone = [];

    _imagePath = [];
    _imagePathClone = [];

  }
}

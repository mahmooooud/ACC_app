import 'dart:convert';
import 'package:acc_app/constants.dart';
import 'package:acc_app/core/service/home_service.dart';
import 'package:acc_app/core/view_model/home_view_model.dart';
import 'package:acc_app/view/categories/category_screen.dart';
import 'package:acc_app/view/landing_screen.dart';
import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:just_audio/just_audio.dart';
 

class HomeScreen extends StatelessWidget {
  String lang = "";
  HomeScreen({this.lang = ""});
  AudioPlayer audioPlayer;
  void playRemoteFile(String soundUrl)async{
    audioPlayer = AudioPlayer();
    var duration = await audioPlayer.setUrl('${soundUrl}');
    print("duration ${duration}");
    audioPlayer.play();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        backgroundColor: Color(0xfff2f4f2),
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            text: "${lang}",
          ),
          backgroundColor: Colors.purple,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
            onPressed: (){
              Get.off(LandingScreen());
            },
          ),
        ),
        body:  controller.loading.value
            ? Center(child: CircularProgressIndicator())
            :SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
             itemCount: controller.homeModel.length,
             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    print("homeModel ${controller.homeModel[index].name}");
                    playRemoteFile(StaticVars.langSelected == 'ar'? controller.homeModel[index].soundAr : controller.homeModel[index].soundEn);
                    controller.updateLocation(controller.homeModel[index].name,controller.homeModel[index].frequency);
                    controller.updateCollection(controller.homeModel[index].name);
                    Get.to(() => CategoryScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
                    child: Image.network(
                       StaticVars.langSelected == 'ar'? "${controller.homeModel[index].imageAr}" : "${controller.homeModel[index].imageEn}"
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



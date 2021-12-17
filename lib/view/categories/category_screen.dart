import 'package:acc_app/constants.dart';
import 'package:acc_app/core/view_model/category_view_model.dart';
import 'package:acc_app/view/home_view/home_screen.dart';
import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:just_audio/just_audio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  AudioPlayer audioPlayer;
  int count = 0;
  void playRemoteFile(String soundUrl)async{
    audioPlayer = AudioPlayer();
    var duration = await audioPlayer.setUrl('${soundUrl}');
    print("duration ${duration}");
    audioPlayer.play();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewModel>(
      init: CategoryViewModel(),
      builder: (controller)=> Scaffold(
        backgroundColor: Color(0xfff2f4f2),
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            text: "Alphabet",
          ),
          backgroundColor: Colors.purple,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
            onPressed: (){
              Get.off(HomeScreen(lang: "English",));
            },
          ),
          actions: [
            StaticVars.collection == "alphabet" || StaticVars.collection == "number"? Container() : IconButton(
                onPressed: (){
                  Get.bottomSheet(
                      StatefulBuilder(
                        builder: (BuildContext context,StateSetter state){
                          return Container(
                            child: Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        color: Colors.black,
                                        text: "Upload Item",
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 2.0,bottom: 15.0),
                                        height: 1.0,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.black,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          controller.filePath.toString() == "[]" || controller.filePath == null || controller.filePath[0].toString() == "null"? InkWell(
                                            onTap: (){
                                              controller.pickFiles(state);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  border: Border.all(color: Colors.black,width: .5)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add,size: 30,color: Colors.black,),
                                                  SizedBox(height: 5.0,),
                                                  CustomText(
                                                    color: Colors.black,
                                                    text: "Sound",
                                                    fontSize: 12.0,
                                                    alignment: Alignment.center,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ): CustomText(
                                            color: Colors.green,
                                            text: "${controller.filePath[0].path.split("/")[controller.filePath[0].path.split("/").length-1]}",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                          SizedBox(width: 20.0,),
                                          controller.imagePath.toString() == "[]" || controller.imagePath == null || controller.imagePath.toString() == "null"? InkWell(
                                            onTap: (){
                                              controller.pickImage(state);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  border: Border.all(color: Colors.black,width: .5)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,size: 30,color: Colors.black,),
                                                  SizedBox(height: 5.0,),
                                                  CustomText(
                                                    color: Colors.black,
                                                    text: "Image",
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):Image.file(
                                            File(controller.imagePath[0].path),
                                            height: 80.0,
                                            width: 80.0,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0,),

                                      (controller.imagePath == null  || controller.filePath == null || controller.filePath.toString() == "[]" || controller.imagePath.toString() == "[]")? Container():
                                      InkWell(
                                        onTap: (){
                                          Get.back();
                                          XsProgressHud.show(context);
                                          controller.loading.value = true;
                                          controller.uploadFile(controller.filePath[0].path).then((value){
                                            controller.uploadImage(controller.imagePath[0].path).then((value){
                                              controller.addCategory();
                                              XsProgressHud.hide();
                                            });
                                          });
                                        },
                                        child: CustomText(
                                          text: "Upload",
                                          fontSize: 20.0,
                                          alignment: Alignment.center,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      enableDrag: true,
                      backgroundColor: Colors.white,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2.0
                          )
                      )
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.0,
                )
            )
          ],
        ),
        body: controller.loading.value
            ? Center(child: CircularProgressIndicator())
            :SingleChildScrollView(
          child: GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.categoryModel.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,index){
              return InkWell(
                // onTap: ()=> playRemoteFile(controller.categoryModel[index].sound),
                onTap: (){
                  XsProgressHud.show(context);
                  // controller.addCategory();
                  setState(() {
                    count ++;
                  });
                  if(count > 1 ){
                    audioPlayer.dispose();
                  }
                  if(StaticVars.collection == "alphabet" || StaticVars.collection == "number"){
                    XsProgressHud.hide();
                  }else{
                    controller.updateData(index,controller.categoryModel[index].frequency);
                  }
                  playRemoteFile(controller.categoryModel[index].sound);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Image.network(
                      "${controller.categoryModel[index].image}"
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}


 import 'package:acc_app/constants.dart';
import 'package:acc_app/view/home_view/home_screen.dart';
import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f4f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f4f2),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                  "assets/images/logoImage.png"
              ),
            ),
            SizedBox(height: 30.0,),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                  "assets/images/let_me_talk.png"
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              child: CustomText(
                alignment: Alignment.center,
                color: Colors.black,
                text: "AAC app for children",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 1.0,
              width: 200.0,
              color: Colors.black38,
            ),
            SizedBox(height: 30.0,),
            Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              child: RaisedButton(
                elevation: 10.0,
                color: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                padding: EdgeInsets.all(20.0),
                onPressed: (){
                  setState(() {
                    StaticVars.langSelected = "en";
                  });
                  print("Tapped");
                  Get.to(HomeScreen(lang: "English",));

                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: CustomText(
                        alignment: Alignment.center,
                        color: Colors.purple,
                        text: "En",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 25.0,),
                    Container(
                      alignment: Alignment.center,
                      child: CustomText(
                        alignment: Alignment.center,
                        color: Colors.black,
                        text: "English Language",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              child: RaisedButton(
                elevation: 10.0,
                color: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                padding: EdgeInsets.all(20.0),
                onPressed: (){
                  setState(() {
                    StaticVars.langSelected = "ar";
                  });
                  Get.to(HomeScreen(lang: "العربية",));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: CustomText(
                        alignment: Alignment.center,
                        color: Colors.orange,
                        text: "Ar",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 25.0,),
                    Container(
                      alignment: Alignment.center,
                      child: CustomText(
                        alignment: Alignment.center,
                        color: Colors.black,
                        text: "اللغة العربية",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




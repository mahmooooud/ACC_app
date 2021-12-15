import 'package:acc_app/constants.dart';
import 'package:acc_app/core/view_model/auth_view_model.dart';
import 'package:acc_app/view/auth/register_view.dart';
import 'package:acc_app/view/widgets/custom_buttom.dart';
import 'package:acc_app/view/widgets/custom_button_social.dart';
import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:acc_app/view/widgets/custom_text_form_field.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  void getCurrentLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      StaticVars.currentLat = _locationData.latitude.toString();
      StaticVars.currentLong = _locationData.longitude.toString();
    });
   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthViewModel(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              right: 20,
              left: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Welcome,",
                        fontSize: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterView());
                        },
                        child: CustomText(
                          text: "Sign Up",
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Sign in to Continue',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Email',
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            controller.email = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              print("ERROR");
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'iamdavid@gmail.com',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Password',
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            controller.password = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              print('error');
                            }
                          },
                          decoration: InputDecoration(
                            hintText: '**********',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      _formKey.currentState.save();

                      if (_formKey.currentState.validate()) {
                        controller.signInWithEmailAndPassword();
                      }
                    },
                    color: kPrimaryColor,
                    child: CustomText(
                      alignment: Alignment.center,
                      text: "SIGN IN",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomText(
                    text: '-OR-',
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey.shade50,
                    ),
                    child: FlatButton(
                      onPressed: (){
                        controller.facebookSignInMethod();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/facebook.png'),
                          SizedBox(
                            width: 100,
                          ),
                          CustomText(
                            text: 'Sign In with Facebook',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey.shade50,
                    ),
                    child: FlatButton(
                      onPressed: (){
                        controller.googleSignInMethod();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/google.png'),
                          SizedBox(
                            width: 100,
                          ),
                          CustomText(
                            text: 'Sign In with Google',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


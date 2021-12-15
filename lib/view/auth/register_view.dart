
import 'package:acc_app/constants.dart';
import 'package:acc_app/core/view_model/auth_view_model.dart';
import 'package:acc_app/view/auth/login_view.dart';
import 'package:acc_app/view/widgets/custom_buttom.dart';
import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:acc_app/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.off(LoginView());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
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
                CustomText(
                  text: "Sign Up,",
                  fontSize: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: [
                      CustomText(
                        text: "Name",
                        fontSize: 14,
                        color: Colors.grey.shade900,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          controller.name = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            print("ERROR");
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Marwan",
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
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: [
                      CustomText(
                        text: "Email",
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
                          hintText: "marwan@gmail.com",
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
                        text: "Password",
                        fontSize: 14,
                        color: Colors.grey.shade900,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          controller.password = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            print("ERROR");
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "**********",
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
                  height: 15,
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    _formKey.currentState.save();

                    if (_formKey.currentState.validate()) {
                      controller.createAccountWithEmailAndPassword();
                    }
                  },
                  color: kPrimaryColor,
                  child: CustomText(
                    alignment: Alignment.center,
                    text: "SIGN Up",
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

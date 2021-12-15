
import 'package:acc_app/constants.dart';
import 'package:acc_app/core/service/firestore_user.dart';
import 'package:acc_app/model/user_model.dart';
import 'package:acc_app/view/home_view/home_screen.dart';
import 'package:acc_app/view/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '', password = '', name = '';

  Rx<User> _user;

  String get user => _user.value.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user);
      Get.offAll(LandingScreen());
    });
  }

  void facebookSignInMethod() async {
    final LoginResult result = await FacebookAuth.instance.login();

      print("enter");
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken.token);
      await _auth.signInWithCredential(facebookAuthCredential).then((user) {
        saveUser(user);
        Get.offAll(LandingScreen());
      });

  }

  void signInWithEmailAndPassword() async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
       StaticVars.userId = user.user.uid;
      Get.offAll(LandingScreen());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(LandingScreen());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveUser(UserCredential user) async {
    print("User ${user.user.displayName}");
    print("User ${name.isEmpty}");
    StaticVars.userId = user.user.uid;
    await FireStoreUser().addUserToFireStore(UserModel(
      userId: user.user.uid,
      email: user.user.email,
      name: name.isEmpty ? user.user.displayName : name,
    ));
  }
}

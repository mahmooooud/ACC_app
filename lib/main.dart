import 'package:acc_app/helper/binding.dart';
import 'package:acc_app/view/auth/login_view.dart';
import 'package:acc_app/view/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      home: LoginView(),
      theme: ThemeData(
        fontFamily: 'NotoSansKannada',
      ),
    );
  }
}
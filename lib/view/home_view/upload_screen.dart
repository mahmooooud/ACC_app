import 'package:acc_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          text: "Upload Category",
        ),
        backgroundColor: Colors.purple,
        elevation: 0.0,

      ),
      backgroundColor: Colors.white,
      // body: ,
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {



  Future<List<QueryDocumentSnapshot>> getCategory(String collection) async {
    final CollectionReference _categoryCollectionRef =
    FirebaseFirestore.instance.collection('${collection}');

  print("catId ${_categoryCollectionRef.doc().id}");
    var value = await _categoryCollectionRef.get();

    return value.docs;
  }
}

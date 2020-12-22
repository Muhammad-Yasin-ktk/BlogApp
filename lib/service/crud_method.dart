import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudMethods{

  Future<void> addData(blogData)async{

    Firestore.instance.collection('blog').add(blogData).catchError((err){
      print(err);
    });
  }
 Future  getData()async {
    return await Firestore.instance.collection('blog').snapshots();
    
  }
}
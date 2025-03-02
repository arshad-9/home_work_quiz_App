import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Models/Classes.dart';
import 'package:untitled/Models/HomeWork.dart';

import '../Models/User.dart';
import 'Firebase_Crud_user_Operations.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getClasses()async{
  print('yess this is also called ');
  return await FirebaseFirestore.instance.collection('Classes').where('memberIds',arrayContains: getUserId()!).get();
}

Future<classes?> createClass(classes c) async {

  var cMap = c.toMap();
   await FirebaseFirestore.instance.collection('Classes').doc(c.id).set(cMap,SetOptions(merge: true))
       .whenComplete((){
    Fluttertoast.showToast(msg: 'Class Created Successfully');
  }).onError((error,stacktrace){
    Fluttertoast.showToast(msg: error.toString());
    print('error::::::: ${error.toString()}');
  });


return null;

}

  Future<void> HomeWorkSubmission(String classId,List<HomeWork>homework) async{
      await FirebaseFirestore.instance.collection('Classes').doc(classId).update({
        'homework': homework.map((b)=>b.toMap()).toList()
      }).whenComplete((){
        print('successful Submission');
      }) .onError((error,stacktrace){
        print("Error : ${error}");
      });

  }

Future<classes?>getClassById(String id)async{
 var snapshot =  await FirebaseFirestore.instance.collection('Classes').doc(id).get();
  if(!snapshot.exists && snapshot.data()==null) {
    print('Classes not Found');
    Fluttertoast.showToast(msg: 'Something went wrong !!');
    return null;
 }
  return classes.fromMap(snapshot.data()!);
}


Future<void>updateClass(HomeWork newHomeWork,String classId)async {

  await FirebaseFirestore.instance.collection('Classes').doc(classId).update({
    'homework':FieldValue.arrayUnion([newHomeWork.toMap()])
  }).whenComplete(
      (){
        Fluttertoast.showToast(msg: 'A homework is added');
      }
  ).onError((error,stacktrace){
    if (kDebugMode) {
      print(error);
    }
  });
}

Future<void>updateClassMembers(String memberId,String classId,user u)async {

  await FirebaseFirestore.instance.collection('Classes').doc(classId).update({
    'memberIds':FieldValue.arrayUnion([memberId]),
    'students':FieldValue.arrayUnion([u.toMap()])
  }).whenComplete(
          (){
        Fluttertoast.showToast(msg: 'Enrollment Successful');
      }
  ).onError((error,stacktrace){
    if (kDebugMode) {
      print(error);
    }
  });
}

// Home Work Related FireStore Calls






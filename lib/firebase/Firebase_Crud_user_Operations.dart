
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Models/Classes.dart';

import '../Models/User.dart';



String? getUserId()=> FirebaseAuth.instance.currentUser?.uid;



Future<user?> getUser()async{
 var snapshot =  await FirebaseFirestore.instance.collection('Users').doc(getUserId()).get();
 if (!snapshot.exists || snapshot.data() == null) {
   print('the id is :${snapshot.data()}');
   return null; // Handle case where user doesn't exist
 }else{
   return user.fromMap(snapshot.data()!);
 }


}

Future<user?> addUser(user u) async{

    await FirebaseFirestore.instance.collection('Users').doc(getUserId()!).set(u.toMap(),SetOptions(merge: true)).whenComplete((){
       Fluttertoast.showToast(msg: 'Account Created Successfully');
     }).onError((error,stacktrace){
       Fluttertoast.showToast(msg: 'Something went wrong');
       if (kDebugMode) {
         print(error.toString());
       }
     });

     return null;
}
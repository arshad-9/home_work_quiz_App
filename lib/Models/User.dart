import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/Models/Classes.dart';

class user{

  late String name ;
  late String mob;
  late String role ;
  late String email;
  late String Id;

  user(this.name, this.mob, this.role, this.email, this.Id);
  user.fromMap(Map<String, dynamic> data) {

    this.name= data['name'];
    this.mob=data['mob'] ;
    this.role=data['role'];
    this.email =data['email'];
    this.Id =data['Id'];

  }

 Map<String,dynamic>toMap(){
   return {
   'name':name,
   'mob':mob,
   'role':role,
   'email':email,
     'Id' : Id,

   };


 }



}
import 'package:untitled/Models/HomeWork.dart';

import 'User.dart';

class classes{
  late String id;
   String name='';
  late List<user>students ;
  List<HomeWork>homework =[];
  late String created_by;
  late List<String>memberIds ;

  classes(this.id, {required this.students, this.created_by = 'Anonymous',required this.name,required this.memberIds});

  classes.fromMap(Map<String,dynamic>data){
    this.students = (data['students'] as List<dynamic>).map((b)=>user.fromMap(b)).toList();
    this.name = data['name'];
    this.created_by =data['created_by'];
    this.id = data['id'];
    this.memberIds =(data['memberIds'] as List<dynamic>).map((b)=>b.toString()).toList();
    this.homework = data['homework']!=null? (data['homework'] as List<dynamic>).map((b)=>HomeWork.fromMap(b)).toList():[];
  }

  Map<String,dynamic>toMap(){
    return {
      'students':this.students.map((b)=>b.toMap()).toList(),
      'name': this.name,
      'id' : this.id ,
      'created_by' : this.created_by,
      'memberIds' :this.memberIds,
      'homework' : this.homework.map((b)=>b.toMap()).toList()
    };
  }


}
import 'package:untitled/Models/User.dart';

class Answer{

  late String name;
  late String userId ;
  late String marks ;

  Answer(this.name, this.userId, this.marks);
  Answer.fromMap(Map<String,dynamic>data){
    name = data['name'];
    marks = data['marks'];
    userId =data['userId'];

  }


 Map<String,dynamic>toMap(){
   return {
     'name': this.name,
   'userId':this.userId,
   'marks':this.marks};
 }




}
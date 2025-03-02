import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';

import '../Models/User.dart';

class MembersPage extends StatefulWidget{
  late List<user>members;

  MembersPage(this.members);

  @override
  State<StatefulWidget> createState() => MembersPageState(members);


}
class MembersPageState extends State<MembersPage>{
  late List<user>members;

  MembersPageState(this.members);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Members',style: HeadlinetextStyle(),),),
      body:ListView.builder(itemBuilder: (context, index) {
    return Card(
    elevation: 3,

    margin: EdgeInsets.symmetric(
    horizontal: 10, vertical: 5),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)),
    child: ListTile(

    title: Text(members[index].name,
    style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(members[index].email),

    ),);

    }, itemCount: members.length)
    );
  }



}
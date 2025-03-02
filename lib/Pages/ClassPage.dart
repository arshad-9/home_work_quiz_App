import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';
import 'package:untitled/Models/HomeWork.dart';
import 'package:untitled/Pages/QuizPage.dart';

import '../Models/Classes.dart';
import '../Models/User.dart';
import '../firebase/FireBase_Crud_Classes_Operations.dart';
import 'CreateHomeWorkPage.dart';
import 'MembersPage.dart';

class ClassPage extends StatefulWidget{
  final user u;
  final String classId;
  final String className;
  ClassPage(this.u,this.classId,this.className);
  @override
  State<StatefulWidget> createState() =>ClassPageState(u:u,classId:classId,className: className);
}

class ClassPageState extends State<ClassPage>{
  final user u;
  classes? c;
  String classId;
  String className ;

  ClassPageState({required this.u, required this.classId,required this.className});




  void _showScoreDialog(String textToCopy) {
    TextEditingController idController = TextEditingController(text: textToCopy);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Copy Text"),
          content: TextField(
            controller: idController,
            readOnly: true, // Make it inactive
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: idController.text));
                Navigator.pop(context);
              },
              child: Text("Copy"),
            ),

          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text(className,style: HeadlinetextStyle(),),
    ),

     body:Container(
       width: double.infinity,
       height: double.infinity,
       color: Colors.blue.shade50,
       child :FutureBuilder(
         future: getClassById(classId),
         builder: (context,snapshot)
         {
           if(snapshot.hasData && snapshot.data!=null){
              c = snapshot.data! ;

             return  ListView.builder(itemBuilder: (context,index){
               return Card(
                 elevation: 3,
                 margin: EdgeInsets.symmetric(
                     horizontal: 10, vertical: 5),
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)),
                 child: ListTile(
                   onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizPage(u:u,Class:c!,index:index)));
                   } ,
                   title: Text(c?.homework[index].title??'', style: TextStyle(fontWeight: FontWeight.bold)),
                   subtitle: Text(c?.homework[index].description??''),
                   trailing: Text("Submitted: ${c?.memberIds.length}", style: TextStyle(color: Colors.blueAccent),
                   ),
                 ),
               );
             },itemCount: c?.homework.length??0,);

           }
           if(snapshot.connectionState == ConnectionState.waiting)
             {
               return const Center( child: CircularProgressIndicator(),);
             }

               return Container();

     },



       ),
       ),

     floatingActionButton: FloatingActionButton(

       elevation: 3,
         child: Icon(Icons.view_agenda_outlined),
         onPressed: (){
    showModalBottomSheet(context: context, builder:(context){
      print('this is the id ::: ${c?.id}');
     return Column(
     children: getWidgetList(c),
     );
     },shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.only(
     topLeft: Radius.circular(20),
     topRight: Radius.circular(20))));

     }),


     );


  }


  
  
  List<Widget>getWidgetList(classes? c){
    if(c!=null){
    var listOfWidgetsForTeacher =[
       ListTile( onTap :() async{
         Navigator.pop(context);
        await  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateHomeWorkPage(u,c)));
        setState(() {});
       }, 
         leading: Icon(Icons.add),
         title: Text('Create HomeWork'),),

    ListTile( onTap :()async{
      Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MembersPage(c.students)));
    },
    leading: Image.asset('assests/images/group.png',height: 30,width: 30,),
    title: Text('Members'),) ,

      ListTile( onTap :()async{
        _showScoreDialog(c.id);
      },
        leading: Image.asset('assests/images/id.png',height: 30,width: 30),
        title: Text('Get Class Id'),)


    ];

    var listOfWidgetForStudents=[

      ListTile( onTap :(){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MembersPage(c.students)));
      },
        leading: Image.asset('assests/images/group.png',height: 30,width: 30),
        title: Text('Members'),)];


    return 'Teacher'== u.role?listOfWidgetsForTeacher:listOfWidgetForStudents;
  }
    return [];
  }




}
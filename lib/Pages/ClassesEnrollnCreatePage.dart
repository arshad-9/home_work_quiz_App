import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';
import 'package:untitled/Models/Classes.dart';
import 'package:untitled/firebase/FireBase_Crud_Classes_Operations.dart';

import '../Models/User.dart';
import 'DashboardPage.dart';

class classEnrollnCreatePage extends StatefulWidget{
  final user u ;
  classEnrollnCreatePage(this.u);

  @override
  State<StatefulWidget> createState()=>classEnrollnCreatePageState(u);
}

class classEnrollnCreatePageState extends State<classEnrollnCreatePage> {

  final user u;

  classEnrollnCreatePageState(this.u);

  @override
  Widget build(BuildContext context) {

    return  MyBuilder();
  }


  StatefulWidget MyBuilder() {
    var classnameController = TextEditingController();
    var mfocusNode = false;

    return Scaffold(
      appBar: AppBar(
          title: Text(u.role=='Teacher'?'Create Class':'Enroll Class', style: HeadlinetextStyle(),)
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue.shade50,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: 400,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(

                  controller: classnameController,
                  onTap: () {
                    mfocusNode = mfocusNode?false:true;
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(u.role=='Teacher'?'Class Name':'Class Id'),
                    labelStyle: TextStyle(
                        color: mfocusNode ? Colors.blue : Colors.grey.shade500),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: 1)),
                  ),
                ),
                SizedBox.square(dimension: 20,),
                SizedBox(width: 300,height: 50,child: ElevatedButton(
                  onPressed: () async {

                    var name = classnameController.text;


                    if(name.isEmpty){   Fluttertoast.showToast(msg: 'You not entered the details');   }
                    else
                    {
                      if(u.role=='Teacher'){
                      var id  = DateTime.now().toString()+name   ;
                      var created_by = u.Id;
                      var Myclass = classes(id,students:[u],created_by: created_by,name: name,memberIds: [created_by]);
                         createClass(Myclass);

                      Navigator.pop(context);

                    }
                      else{
                        classes? c = await getClassById(name);
                         if(c!=null){
                          await updateClassMembers(u.Id, c.id,u);
                          Navigator.pop(context);
                        }else{
                          Fluttertoast.showToast(msg: 'Enrollment Failed ! Something went wrong');
                        }

                      }

                  }

                  },
                  style: elevatedButtonStyle(),
                  child: Text(u.role=='Teacher'?'Create':'Enroll',style:
                  TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ),)
              ],
            ),
          ),
        ),),
    );
  }



}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';
import 'package:untitled/Pages/SigningPage.dart';
import 'package:untitled/firebase/Firebase_Crud_user_Operations.dart';

import '../Models/User.dart';
import 'DashboardPage.dart';

class AccountPage extends StatefulWidget {
 final String role;
  const AccountPage( {super.key, required this.role});
  @override
  State<StatefulWidget> createState() => AccountPageState(role);
}

class AccountPageState extends State<AccountPage>{
  String role;
  AccountPageState(this.role);
  var nameController = TextEditingController();
  var institiuteController = TextEditingController();
  var numberController = TextEditingController();
  var mfocusNode = false;
  var mfocusNode2 = false;
  var mfocusNode3 = false;




  @override
  Widget build(BuildContext context) {
    var mediaq=MediaQuery.of(context).size;
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Create Account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body: Container(
        height: (mediaq.width<600)?mediaq.width:mediaq.height,
        child: Padding(
          padding: EdgeInsets.only(top:(mediaq.width<600)?mediaq.width*0.02:mediaq.height*0.02,
              right: (mediaq.width<600)?mediaq.width*0.06:mediaq.height*0.06,left:(mediaq.width<600)?mediaq.width*0.06:mediaq.height*0.06),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

               SizedBox.square(dimension: 20,),
                TextField(
                  maxLength: 20,
                  controller: nameController,
                  onTap: (){mfocusNode=true;
                    mfocusNode2=false;
                    mfocusNode3=false;
                    setState(() {});},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    labelStyle: TextStyle(color: mfocusNode?Colors.blue:Colors.grey.shade500),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.blue,width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.grey.shade500,width: 1)),
                  ),
                ),
                  
                TextField(
                  maxLength: 10,
                  controller: numberController,
                 onTap: (){mfocusNode2 = true;
                   mfocusNode= false;
                  mfocusNode3=false;
                   setState(() {});},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Mobile No'),
                    labelStyle: TextStyle(color: mfocusNode2?Colors.blue:Colors.grey.shade500),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.blue,width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.grey.shade500,width: 1)),
                  ),
                ),
                TextField(
                  maxLength: 60,
                  controller: institiuteController,
                  onTap: (){mfocusNode3 = true;
                  mfocusNode= false;
                  mfocusNode2=false;
                  setState(() {});},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text('institute Name '),
                    labelStyle: TextStyle(color: mfocusNode3?Colors.blue:Colors.grey.shade500),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.blue,width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.grey.shade500,width: 1)),
                  ),
                ),
                  
                     Text('Role : $role',style:
             TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),),
                  
                SizedBox.square(dimension: 10,),
                  
                  
                SizedBox(width: 300,height: 50,child: ElevatedButton(
                  onPressed: (){
                   var name = nameController.text;
                   var num = numberController.text;
                   var email = FirebaseAuth.instance.currentUser?.email!;
                   if(num.isEmpty || name.isEmpty|| email==null){
                     Fluttertoast.showToast(msg: 'Invalid entry');
                   }else{
                     user u = user(name,num,role,email,getUserId()!);
                     addUser(u);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                   }



                  },
                  style: elevatedButtonStyle(),
                  child: Text('Save and Continue',style:
                 buttonTextStyle(),),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

}


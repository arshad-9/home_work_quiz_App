import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Pages/DashboardPage.dart';

import '../CustomWidgetStyles/CustomStyles.dart';
import '../Models/User.dart';
import '../firebase/Firebase_Crud_user_Operations.dart';
import '../firebase/firebaseAuthentication.dart';
import 'RoleSelectionPage.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => SigningPageState();
}

class SigningPageState extends State<SigningPage> {

  var emailEditor = TextEditingController();
  var passwordEditor = TextEditingController();
  String button_text = 'Sign Up';
  String navText ='Sign In';
  String ifAccount = 'Already have an account? ';
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.blue,


          title: Text('Homework Quiz',style: TextStyle(color: Colors.white),),
        ),
        body:Center(
          child: Container(
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(button_text,style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                        color: Colors.black)),
                  ),
                  TextField(
                    controller: emailEditor,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                            ,borderSide: BorderSide(color:Colors.blue,width: 2))
                    ),
                  ),
                  TextField(
                    controller: passwordEditor,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                            ,borderSide: BorderSide(color:Colors.black,width: 2))
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(onPressed: () async{
                      if(button_text == 'Sign Up'){
                       var data =  await  firebaseRegister(emailEditor.text, passwordEditor.text);
                       if(data!= null){
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RoleSelctionPage()));
                       }}

                     else{
                       var data=  await firebaseSignIn(emailEditor.text, passwordEditor.text);
                       if(data!= null){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                           }}
                      },


                      child: Text(button_text,style: TextStyle(color: Colors.white),),
                      style: elevatedButtonStyle(),
                    ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(ifAccount),
                      InkWell(
                          onTap: (){
                            setState(() {
                              print('this is hitting ');
                              if(button_text == 'Sign Up' && navText =='Sign In'){
                                button_text =' Sign In';
                                navText ='Sign Up';
                                ifAccount ="Don't have an Account?  ";
                                print('this is hitting  1 if vala ');
                              }else{
                                button_text ='Sign Up';
                                navText ='Sign In';
                                ifAccount ="Already have an Account? ";
                                print('this is hitting  2  ');
                              }
                            });
                          },
                          child: Text(navText,style: TextStyle(fontSize:20,color:Colors.indigo),)),
                    ],
                  )



                ],
              ),
            ),
          ),
        )

    );
  }
}


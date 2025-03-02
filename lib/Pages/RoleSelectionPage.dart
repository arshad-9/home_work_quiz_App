import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountPage.dart';


class RoleSelctionPage extends StatefulWidget {
  const RoleSelctionPage({super.key});

  @override
  State<RoleSelctionPage> createState() => RoleSelctionPageState();
}

class RoleSelctionPageState extends State<RoleSelctionPage> {
  var background_btn_color = Colors.grey;
  var selected_role ='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Padding(
              padding: const EdgeInsets.only(top: 60.0,bottom: 10,right: 20,left: 20),

              child:Column(
                  children: [
                    Align(
                      alignment: Alignment(-0.8,0.1),
                        child: Text('Countinue as : ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    SizedBox(
                      height: 150,
                      child: Row(
                
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                          children: [
                            Expanded(
                              flex: 2,
                              child: OutlinedButton(onPressed: (){

                               setState(() {
                                 selected_role ='Student';
                                 background_btn_color = Colors.blue;
                               });
                
                               },
                                style:OutlinedButton.styleFrom(backgroundColor:selected_role=='Student'?Colors.blue.shade50:Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(borderRadius:
                              BorderRadius.circular(10)),side: BorderSide(color: selected_role=='Student'?Colors.blue:Colors.grey),)
                
                                , child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assests/images/study.png',height: 60,width: 60,),
                                  SizedBox.square(dimension: 5),
                                  Text('Student',style: TextStyle(color: Colors.blue,fontSize: 20))
                                ],
                                                    ),),
                            ),
                             SizedBox.square(dimension: 50,),

                            Expanded(
                              flex: 2,
                              child: OutlinedButton(onPressed: (){
                                selected_role ='Teacher';
                                background_btn_color =Colors.blue;
                                setState(() { });
                              },
                                style:OutlinedButton.styleFrom(backgroundColor:selected_role=='Teacher'?Colors.blue.shade50:Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(borderRadius:
                              BorderRadius.circular(10)), side:BorderSide(color: selected_role=='Teacher'?Colors.blue:Colors.grey),)

                              , child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assests/images/school.png',height: 60,width: 60,),
                                  SizedBox.square(dimension: 5,),
                                  Text('Teacher',style: TextStyle(color: Colors.blue,fontSize: 20),)
                                ],
                              ),),
                            )
                        ],
                      ),
                    ),
                 Expanded(child: Container()),

                   SizedBox(
                    height: 45,
                   width: 350,
                    child: ElevatedButton(onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountPage(role:selected_role)));

                    },style:ElevatedButton.styleFrom(backgroundColor: background_btn_color,shape: RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(10),),), child: Text("Continue",style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold))),
                  ),

                        ],
                ),
              ),





    );
  }
}

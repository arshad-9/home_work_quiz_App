
import 'package:flutter/material.dart';

ButtonStyle elevatedButtonStyle(){
  return ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius:
  BorderRadius.all(Radius.circular(10))),backgroundColor: Colors.blue);
}

TextStyle HeadlinetextStyle(){
  return  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25);
}
TextStyle buttonTextStyle(){
  return  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20);
}
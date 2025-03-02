
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String?> firebaseRegister(String? email,String? password) async{
  if(email== null || password==null)
    {
   Fluttertoast.showToast(msg: 'name or password is not Filled');
      print('name or password is not Filled');
    }
  try {
    var userCredentials  =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!,
        password: password!);
      return userCredentials.user!.uid;
    print('success full');
  } on FirebaseException catch (e) {

   Fluttertoast.showToast(msg: e.message!);
   return null;
  }

}

Future<String?> firebaseSignIn(String? email,String? password) async{
  if(email== null || password==null)
  {
    Fluttertoast.showToast(msg: 'name or password is not Filled');
    print('name or password is not Filled');
  }
   try {
     var userCredentials  = await FirebaseAuth.instance
         .signInWithEmailAndPassword(email: email!, password: password!);
     print('user iD On SIgn In :: ${userCredentials.user?.uid}');
     return userCredentials.user?.uid;
   } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
      return null;
   }


}


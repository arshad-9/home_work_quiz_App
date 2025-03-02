import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/CustomWidgetStyles/CustomStyles.dart';
import 'package:untitled/Models/Classes.dart';
import 'package:untitled/Models/HomeWork.dart';
import 'package:untitled/Pages/ClassPage.dart';

import '../Models/Quizquestion.dart';
import '../Models/User.dart';
import '../firebase/FireBase_Crud_Classes_Operations.dart';

class CreateHomeWorkPage extends StatefulWidget{
  final user u;
  final classes c;

  @override
  State<StatefulWidget> createState() => CreateHomeWorkPageState(u,c);

  CreateHomeWorkPage(this.u, this.c);


}
class CreateHomeWorkPageState extends State<CreateHomeWorkPage>{
  final user u;
  final classes c;


  CreateHomeWorkPageState(this.u, this.c);

  List<quizQuestion> questionsList=[];

  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController correctOptionController = TextEditingController();

  var titleController  = TextEditingController();
  var descriptionController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Create Homework',style: HeadlinetextStyle(),),
     ),
      body: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,top: 5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                TextField(

                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text('Add title '),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.blue,width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.grey.shade500,width: 1)),
                  ),
                ),
                TextField(

                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text('Add Description'),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.blue,width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:Colors.grey.shade500,width: 1)),
                  ),
                ),

                SizedBox.square(dimension: 5,),

                Text('Questestion Added : ${questionsList.length}'),

                SizedBox.square(dimension: 5,),

                SizedBox(width: 300,height: 50,
                  child: ElevatedButton(

                onPressed: () => showAddQuestionDialog(context),
                    style: elevatedButtonStyle(),
                    child: Text('Add question',style:
                    buttonTextStyle(),),
                  ),),



                SizedBox(width: 300,height: 50,
                  child: ElevatedButton(
                  onPressed: (){
                    var title = titleController.text;
                    var des = descriptionController.text;

                    if( des.isEmpty){
                      Fluttertoast.showToast(msg: 'Description left unfilled');
                    }else{
                      var homework = HomeWork(title: title, description: des, students: questionsList,submission: []);
                      print("this quests list is  :: :: :: !!!! :: ${questionsList.length}");
                      updateClass(homework,c.id);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassPage(u,c.id,c.name)));
                    }



                  },
                  style: elevatedButtonStyle(),
                  child: Text('create',style:
                  buttonTextStyle(),),
                ),)

              ],
            ),
          ),
        ),
      ),
    );
  }



  void showAddQuestionDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SingleChildScrollView(
            child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: questionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Question",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: option1Controller,
                          decoration: InputDecoration(
                            labelText: "Option 1",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: option2Controller,
                          decoration: InputDecoration(
                            labelText: "Option 2",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: option3Controller,
                          decoration: InputDecoration(
                            labelText: "Option 3",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: option4Controller,
                          decoration: InputDecoration(
                            labelText: "Option 4",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: correctOptionController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Correct Option (1-4)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (questionController.text.isNotEmpty &&
                                option1Controller.text.isNotEmpty &&
                                option2Controller.text.isNotEmpty &&
                                option3Controller.text.isNotEmpty &&
                                option4Controller.text.isNotEmpty &&
                                correctOptionController.text.isNotEmpty) {
                              try {
                                int correctOption = int.parse(correctOptionController.text);
                                if (correctOption < 1 || correctOption > 4) {
                                  throw FormatException();
                                }

                                quizQuestion newQuestion = quizQuestion(
                                  question: questionController.text,
                                  options: [option1Controller.text,
                                   option2Controller.text,
                                   option3Controller.text,
                                   option4Controller.text],
                                  correct: correctOptionController.text,
                                );

                                questionsList.add(newQuestion);
                                setState(() {});
                                Navigator.pop(context); // Close dialog
                              } catch (e) {
                                print("Invalid correct option value");
                              }
                            } else {
                              print("Please fill all fields");
                            }
                          },
                          child: Text("Add Question"),
                        ),
                      ],
                    ),
                  ),
                ),

          ),
        );
      },
    );
  }


}
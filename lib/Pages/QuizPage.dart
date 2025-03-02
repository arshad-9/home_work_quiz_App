import 'package:flutter/material.dart';
import 'package:untitled/Models/Answer.dart';
import 'package:untitled/Models/Quizquestion.dart';
import 'package:untitled/Pages/Result%20Page.dart';

import '../Models/Classes.dart';
import '../Models/HomeWork.dart';
import '../Models/User.dart';
import '../firebase/FireBase_Crud_Classes_Operations.dart';

class QuizPage extends StatefulWidget {
   late user u;
   late classes Class;
   late int index;

  @override
  _QuizPageState createState() => _QuizPageState(u:u,c:Class,Index:index);

   QuizPage({required this.u, required this.Class,required this.index});
}

class _QuizPageState extends State<QuizPage> {
 late  int Index;
  late classes c;
  late user u;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedOption; // Store the selected option index (0-3)
  late List<quizQuestion>questions;

  bool alreadyClicked = false;
  _QuizPageState({required this.u, required this.c,required this.Index}){
    questions = c.homework[Index].students;
  }



  void _onOptionSelected(int index) {
    print('clicking on option clicked ');
    setState(() {
      selectedOption = index;

      // Check if selected option is correct
      if (selectedOption!+1 == int.parse(questions[currentQuestionIndex].correct ) && !alreadyClicked) {
        score++;
        alreadyClicked = true ;
        print('the score increment :: $score ');
      }
    });
  }

  void _onNext() {
    setState(()  {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = null;
        alreadyClicked = false ;// Reset selection for next question
      } else {
        // Quiz finished
        c.homework[Index].submission.add( Answer(u.name,u.Id,score.toString()));
         HomeWorkSubmission(c.id,c.homework);
        print("score ::::::::_:_:_:_:::::::::::$score");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultPage(score: score,
            totalQuestions:questions.length,userScores:c.homework[Index].submission)));
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit"),
        content: Text("Are you sure you want to quit the quiz"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultPage(score: score,
                totalQuestions:questions.length,userScores:c.homework[Index].submission)));
            },
          child: Text("OK")
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("wait"),

          ),

        ],
      ),
    );
  }

  void _onQuit() {
   _showScoreDialog(); // Closes the quiz
  }

  @override
  Widget build(BuildContext context) {
    quizQuestion currentQuestion = questions[currentQuestionIndex];
    print('current :: ${questions[currentQuestionIndex].question}');

    return PopScope(
      canPop: currentQuestionIndex>=questions.length,
      onPopInvokedWithResult: (didpop,result){
          _onQuit();

      },
      child: Scaffold(
        appBar: AppBar(title: Text(c.homework[Index].title)),
        body: Container(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${currentQuestionIndex + 1}/${questions.length} ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  currentQuestion.question,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Column(
                    children: [...List.generate(currentQuestion.options.length, (index) {
                  bool isSelected = selectedOption == index;
                  return GestureDetector(
                    onTap: () => _onOptionSelected(index),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.lightBlue.shade50 : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade50,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(currentQuestion.options[index]),
                      ),
                    ),
                  );
                }),]),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _onQuit,
                        child: Text("Quit",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _onNext,
                        child: Text(currentQuestionIndex < questions.length - 1 ? "Next" : "Finish"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


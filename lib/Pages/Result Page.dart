import 'package:flutter/material.dart';

import '../Models/Answer.dart';

class ResultPage extends StatelessWidget {
  final  int score;
  final int totalQuestions;

  final List<Answer> userScores; // List of users and their scores

  ResultPage( {
    required this.score,
    required this.totalQuestions,
    required this.userScores,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Trophy Image
            Image.asset(
              'assests/images/trophy.png', // Make sure this image is in your assets folder
              width: 100,
              height: 100,
            ),

            SizedBox(height: 20),

            // Current User Score
            Text(
              "Your Score: $score / $totalQuestions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // User Scores List
            Expanded(
              child: ListView.builder(
                itemCount: userScores.length,
                itemBuilder: (context, index) {
                  var user = userScores[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(user.name, style: TextStyle(fontSize: 16)),
                      trailing: Text(
                        "${user.marks} / $totalQuestions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

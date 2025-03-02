import 'Answer.dart';
import 'Quizquestion.dart';


class HomeWork {
  late String title;
  late String description;
  late List<quizQuestion>students ;
  late List<Answer>submission;


  // DateTime due;

  HomeWork({required this.title, required this.description,required this.students,required this.submission});
  HomeWork.fromMap(Map<String, dynamic>data){
    this.title = data['title'];
    this.description = data['description'];
    this.students = (data['students'] as List<dynamic>).map((b)=>quizQuestion.fromMap(b)).toList();
    this.submission = (data['submission'] as List<dynamic>).map((b)=>Answer.fromMap(b)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'students':this.students.map((b)=>b.toMap()).toList(),
      'submission':this.submission.map((b)=>b.toMap()).toList()


    };
  }


}
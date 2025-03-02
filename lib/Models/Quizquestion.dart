class quizQuestion{
  late String question ;
  late List<String>options;
  late String correct;

  quizQuestion({required this.question, required this.options, required this.correct});

  quizQuestion.fromMap(Map<String,dynamic>data){
    this.correct = data['correct']??'';
    this.options = (data['options'] as List<dynamic>).map((b)=>b.toString()).toList()??[];
    this.question =data['question']??'';
    // data['option']!=null?
  }

  Map<String,dynamic>toMap()
  {
    return {
      'correct':this.correct,
      'options':this.options,
      'question':this.question
    };
  }

}
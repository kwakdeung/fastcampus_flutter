import 'package:realtime_quiz_app/model/problem.dart';

class QuizManager {
  List<ProblemManager>? problems;
  String? title;
  ProblemManager? answer;

  QuizManager({this.problems, this.title, this.answer});
}

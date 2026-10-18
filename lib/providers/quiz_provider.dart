import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/dummy_data.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isQuizFinished => _isQuizFinished;
  List<Question> get questions => dummyQuestions;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (dummyQuestions[_currentQuestionIndex].correctOptionIndex ==
        selectedIndex) {
      _score++;
    }

    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _isQuizFinished = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizFinished = false;
    notifyListeners();
  }
}
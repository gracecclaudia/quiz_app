import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';
import '../data/dummy_data.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  // state settings
  bool _isDarkMode = false;
  bool _soundEnabled = true;
  bool _hapticEnabled = true;
  double _fontSizeMultiplier = 1.0; // 1.0 = normal, 1.15 = large, 1.3 = extra
  int _totalQuestionsAnsweredAllTime = 0;

  bool get isDarkMode => _isDarkMode;
  bool get soundEnabled => _soundEnabled;
  bool get hapticEnabled => _hapticEnabled;
  double get fontSizeMultiplier => _fontSizeMultiplier;
  int get totalQuestionsAnsweredAllTime => _totalQuestionsAnsweredAllTime;

  String _selectedCategory = "Kriptografi";
  String _selectedDifficulty = "Campuran";
  List<Question> _filteredQuestions = [];

  final Map<int, int> _selectedAnswers = {};
  final Map<String, int> _userAttempts = {};

  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isQuizFinished => _isQuizFinished;
  List<Question> get questions => _filteredQuestions;
  Map<int, int> get selectedAnswers => _selectedAnswers;
  int get currentUserAttempt => _userAttempts[_userName] ?? 0;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleSound(bool value) {
    _soundEnabled = value;
    notifyListeners();
  }

  void toggleHaptic(bool value) {
    _hapticEnabled = value;
    if (value) HapticFeedback.lightImpact();
    notifyListeners();
  }

  void setFontSizeMultiplier(double multiplier) {
    _fontSizeMultiplier = multiplier;
    notifyListeners();
  }

  // fungsi reset riwayat Kuis dengan pesan sukses
  String resetAllHistory() {
    _userAttempts.clear();
    _totalQuestionsAnsweredAllTime = 0;
    notifyListeners();
    return "Success: All quiz history and statistics have been reset.";
  }

  void clearUser() {
    _userName = '';
    notifyListeners();
  }

  void prepareQuiz(String category, String difficulty, int count) {
    _selectedCategory = category;
    _selectedDifficulty = difficulty;

    var primaryQuestions = dummyQuestions.where((q) => q.category == category).toList();
    if (difficulty != "Campuran") {
      primaryQuestions = primaryQuestions.where((q) => q.difficulty == difficulty).toList();
    }
    primaryQuestions.shuffle();

    if (primaryQuestions.length >= count) {
      _filteredQuestions = primaryQuestions.sublist(0, count);
    } else {
      _filteredQuestions = List.from(primaryQuestions);
      int shortage = count - primaryQuestions.length;
      var backupQuestions = dummyQuestions.where((q) => !primaryQuestions.contains(q)).toList();
      backupQuestions.shuffle();
      for (int i = 0; i < shortage && i < backupQuestions.length; i++) {
        _filteredQuestions.add(backupQuestions[i]);
      }
    }

    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizFinished = false;
    _selectedAnswers.clear();
    notifyListeners();
  }

  void selectAnswer(int selectedIndex) {
    _selectedAnswers[_currentQuestionIndex] = selectedIndex;
    if (_hapticEnabled) {
      HapticFeedback.selectionClick();
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _filteredQuestions.length - 1) {
      _currentQuestionIndex++;
      if (_hapticEnabled) HapticFeedback.selectionClick();
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      if (_hapticEnabled) HapticFeedback.selectionClick();
      notifyListeners();
    }
  }

  void submitQuiz() {
    _score = 0;
    for (int i = 0; i < _filteredQuestions.length; i++) {
      if (_selectedAnswers.containsKey(i)) {
        if (_filteredQuestions[i].correctOptionIndex == _selectedAnswers[i]) {
          _score++;
        }
      }
    }
    _isQuizFinished = true;
    _totalQuestionsAnsweredAllTime += _filteredQuestions.length;

    if (_userName.isNotEmpty) {
      _userAttempts[_userName] = (_userAttempts[_userName] ?? 0) + 1;
    }

    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizFinished = false;
    _selectedAnswers.clear();
    notifyListeners();
  }
}
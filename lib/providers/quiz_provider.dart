import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/dummy_data.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  String _selectedCategory = "Kriptografi";
  String _selectedDifficulty = "Campuran";
  List<Question> _filteredQuestions = [];

  final Map<int, int> _selectedAnswers = {};

  // menyimpan jumlah percobaan kuis berdasarkan nama user
  final Map<String, int> _userAttempts = {};

  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isQuizFinished => _isQuizFinished;
  List<Question> get questions => _filteredQuestions;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  // mengambil jumlah percobaan untuk user yang sedang aktif
  int get currentUserAttempt => _userAttempts[_userName] ?? 0;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  // fungsi untuk menghapus data user saat logout/ganti Pengguna
  void clearUser() {
    _userName = '';
    notifyListeners();
  }

  void prepareQuiz(String category, String difficulty, int count) {
    _selectedCategory = category;
    _selectedDifficulty = difficulty;

    // ambil semua soal dari kategori yang dipilih
    var primaryQuestions = dummyQuestions.where((q) => q.category == category).toList();

    // filter berdasarkan tingkat kesulitan
    if (difficulty != "Campuran") {
      primaryQuestions = primaryQuestions.where((q) => q.difficulty == difficulty).toList();
    }

    // ccak urutan soal utama
    primaryQuestions.shuffle();

    // cek apakah soal utama mencukupi jumlah yang diminta
    if (primaryQuestions.length >= count) {
      _filteredQuestions = primaryQuestions.sublist(0, count);
    } else {
      // jika tidak cukup, masukkan semua soal utama lalu tambahkan soal cadangan
      _filteredQuestions = List.from(primaryQuestions);
      int shortage = count - primaryQuestions.length;

      var backupQuestions = dummyQuestions.where((q) {
        return !primaryQuestions.contains(q);
      }).toList();

      backupQuestions.shuffle();

      for (int i = 0; i < shortage && i < backupQuestions.length; i++) {
        _filteredQuestions.add(backupQuestions[i]);
      }
    }

    // reset status navigasi dan skor kuis
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizFinished = false;
    _selectedAnswers.clear();
    notifyListeners();
  }

  void selectAnswer(int selectedIndex) {
    _selectedAnswers[_currentQuestionIndex] = selectedIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _filteredQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
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
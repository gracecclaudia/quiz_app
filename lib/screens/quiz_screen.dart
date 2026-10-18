import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Kuis'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Soal-soal kuis akan muncul di sini nanti!'),
      ),
    );
  }
}
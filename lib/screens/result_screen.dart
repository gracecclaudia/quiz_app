import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'preparation_screen.dart';
import 'review_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final score = quizProvider.score;
    final totalQuestions = quizProvider.questions.length;
    final percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;
    final attemptCount = quizProvider.currentUserAttempt;

    String message;
    if (percentage >= 80) {
      message = 'Awesome job,';
    } else if (percentage >= 50) {
      message = 'Good effort,';
    } else {
      message = 'Keep trying,';
    }

    return Scaffold(
      backgroundColor: AppTheme.lightPink,
      body: SafeArea(
        child: Center(
          // SingleChildScrollView agar layar bisa discroll
          // jika layar HP user ukurannya kecil
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryPink.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      size: 90,
                      color: AppTheme.lightGreen,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.lightPink.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Attempt #$attemptCount',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '$message\n${quizProvider.userName}!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 25),

                    const Text(
                      'Correct Answers',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$score / $totalQuestions',
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 30),

                    PrimaryButton(
                      text: 'Play Again',
                      onPressed: () {
                        quizProvider.resetQuiz();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PreparationScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ReviewScreen()),
                        );
                      },
                      child: const Text(
                        'Review Answers',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
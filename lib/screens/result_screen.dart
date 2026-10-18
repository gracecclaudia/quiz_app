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
    final quizProvider = Provider.of<QuizProvider>(context);
    final score = quizProvider.score;
    final totalQuestions = quizProvider.questions.length;
    final percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;
    final attemptCount = quizProvider.currentUserAttempt;
    final isDark = quizProvider.isDarkMode;

    String message;
    if (percentage >= 80) {
      message = 'Awesome job,';
    } else if (percentage >= 50) {
      message = 'Good effort,';
    } else {
      message = 'Keep trying,';
    }

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : AppTheme.lightPink,
      // app bar dgn tombol close
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: isDark ? Colors.white : AppTheme.darkGreen,
              size: 30,
            ),
            tooltip: 'Back to Home',
            onPressed: () {
              // reset kuis dan kembali ke halaman preparation (home)
              quizProvider.resetQuiz();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PreparationScreen()),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryPink.withValues(alpha: isDark ? 0.0 : 0.3),
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
                        color: AppTheme.lightPink.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Attempt #$attemptCount',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '$message\n${quizProvider.userName}!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppTheme.darkGreen,
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

                    // tombol play again
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

                    // tombol review
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
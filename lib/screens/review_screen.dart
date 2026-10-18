import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);
    final questions = provider.questions;
    final selectedAnswers = provider.selectedAnswers;
    final isDark = provider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppTheme.lightPink,
        elevation: 0,
        title: Text(
          'Review Answers',
          style: TextStyle(
            fontFamily: 'MountainsOfChristmas',
            fontSize: 32,
            color: isDark ? Colors.white : AppTheme.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : AppTheme.darkGreen),
      ),
      body: SafeArea(
        child: Center(
          // pembatas lebar agar tampilan review tetap rapi di web/laptop
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final userAnswerIndex = selectedAnswers[index];

                final isCorrect = userAnswerIndex == question.correctOptionIndex;
                final isUnanswered = userAnswerIndex == null;

                return Card(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: isDark ? Colors.white24 : AppTheme.lightPink.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Q${index + 1}: ${question.text}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDark ? Colors.white : AppTheme.darkGreen,
                          ),
                        ),
                        const Divider(height: 25, color: AppTheme.lightPink),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? AppTheme.lightGreen : Colors.red.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Your Answer: ${isUnanswered ? "Not Answered" : question.options[userAnswerIndex]}',
                                style: TextStyle(
                                  color: isCorrect ? AppTheme.lightGreen : Colors.red.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (!isCorrect) ...[
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle_outline, color: isDark ? AppTheme.lightGreen : AppTheme.darkGreen, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Correct Answer: ${question.options[question.correctOptionIndex]}',
                                  style: TextStyle(
                                    color: isDark ? AppTheme.lightGreen : AppTheme.darkGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 15),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2C2C2C) : AppTheme.lightPink.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.lightPink.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                color: AppTheme.lightGreen,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Explanation: ${question.explanation}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? Colors.white70 : AppTheme.darkGreen,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
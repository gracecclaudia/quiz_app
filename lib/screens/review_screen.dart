import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    final questions = provider.questions;
    final selectedAnswers = provider.selectedAnswers;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: AppTheme.lightPink,
        elevation: 0,
        title: const Text(
          'Review Answers',
          style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.darkGreen),
      ),
      // menggunakan SafeArea dan menonaktifkan properti yang membatasi scroll
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(), // efek pantulan scroll
          padding: const EdgeInsets.all(20),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final userAnswerIndex = selectedAnswers[index];

            final isCorrect = userAnswerIndex == question.correctOptionIndex;
            final isUnanswered = userAnswerIndex == null;

            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: AppTheme.lightPink.withOpacity(0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // teks soal
                    Text(
                      'Q${index + 1}: ${question.text}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.darkGreen),
                    ),
                    const Divider(height: 25, color: AppTheme.lightPink),

                    // jawaban user
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

                    // jawaban benar (jika user salah)
                    if (!isCorrect) ...[
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_outline, color: AppTheme.darkGreen, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Correct Answer: ${question.options[question.correctOptionIndex]}',
                              style: const TextStyle(
                                color: AppTheme.darkGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 15),

                    // kotak explanation
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.lightPink.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.lightPink),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.lightbulb_outline,
                            color: AppTheme.darkGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Explanation: ${question.explanation}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.darkGreen,
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
    );
  }
}
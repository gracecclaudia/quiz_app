import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/option_card.dart';
import 'result_screen.dart';
import 'preparation_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _submitQuiz(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    provider.submitQuiz();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ResultScreen()),
    );
  }

  // dialog konfirmasi berhenti
  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Quit Quiz?',
          style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to quit? Your current progress will be lost.',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // tutup dialog, lanjutkan kuis
            },
            child: const Text('No, Continue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(); // tutup dialog

              // reset kuis dan kembali ke pengaturan
              Provider.of<QuizProvider>(context, listen: false).resetQuiz();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PreparationScreen()),
              );
            },
            child: const Text('Yes, Quit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: AppTheme.lightPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Quiz Time!',
          style: TextStyle(
            fontFamily: 'MountainsOfChristmas',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkGreen,
          ),
        ),
        automaticallyImplyLeading: false,
        // tombol cancel/close di kanan atas
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded, color: AppTheme.darkGreen, size: 28),
            onPressed: () => _showQuitDialog(context),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          final question = quizProvider.questions[quizProvider.currentQuestionIndex];
          final progress = (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length;

          final isLastQuestion = quizProvider.currentQuestionIndex == quizProvider.questions.length - 1;
          final hasAnsweredCurrent = quizProvider.selectedAnswers.containsKey(quizProvider.currentQuestionIndex);

          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.lightPink.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.lightGreen),
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 20),
                Text(
                  'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightGreen,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  question.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkGreen,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final isSelected = quizProvider.selectedAnswers[quizProvider.currentQuestionIndex] == index;
                      return OptionCard(
                        optionText: question.options[index],
                        isSelected: isSelected,
                        onTap: () {
                          quizProvider.selectAnswer(index);
                        },
                      );
                    },
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: quizProvider.currentQuestionIndex > 0
                            ? () => quizProvider.previousQuestion()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.lightPink,
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Previous',
                          style: TextStyle(color: AppTheme.darkGreen, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: hasAnsweredCurrent
                            ? (isLastQuestion
                            ? () => _submitQuiz(context)
                            : () => quizProvider.nextQuestion())
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.lightGreen,
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: hasAnsweredCurrent ? 2 : 0,
                        ),
                        child: Text(
                          isLastQuestion ? 'Submit' : 'Next',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
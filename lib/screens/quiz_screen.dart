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

  void _showQuitDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Quit Quiz?',
          style: TextStyle(
            color: isDark ? Colors.white : AppTheme.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to quit? Your current progress will be lost.',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No, Continue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
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
    final quizProvider = Provider.of<QuizProvider>(context);
    final isDark = quizProvider.isDarkMode;
    final fontScale = quizProvider.fontSizeMultiplier;

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktopOrTablet = screenWidth > 768;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppTheme.lightPink,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Quiz Time!',
          style: TextStyle(
            fontFamily: 'MountainsOfChristmas',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppTheme.darkGreen,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close_rounded, color: isDark ? Colors.white : AppTheme.darkGreen, size: 28),
            onPressed: () => _showQuitDialog(context, isDark),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Container(
          // membatasi lebar maksimum di layar besar
          constraints: BoxConstraints(
            maxWidth: isDesktopOrTablet ? 750 : double.infinity,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktopOrTablet ? 40 : 25,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length,
                backgroundColor: isDark ? Colors.white12 : AppTheme.lightPink.withValues(alpha: 0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.lightGreen),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
              Text(
                'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.questions.length}',
                style: TextStyle(
                  fontSize: 16 * fontScale,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightGreen,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                quizProvider.questions[quizProvider.currentQuestionIndex].text,
                style: TextStyle(
                  fontSize: 22 * fontScale,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.darkGreen,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),

              // daftar opsi jawaban
              Expanded(
                child: ListView.builder(
                  itemCount: quizProvider.questions[quizProvider.currentQuestionIndex].options.length,
                  itemBuilder: (context, index) {
                    final question = quizProvider.questions[quizProvider.currentQuestionIndex];
                    final isSelected = quizProvider.selectedAnswers[quizProvider.currentQuestionIndex] == index;
                    return OptionCard(
                      optionText: question.options[index],
                      isSelected: isSelected,
                      onTap: () => quizProvider.selectAnswer(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              // tombol navigasi
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: quizProvider.currentQuestionIndex > 0
                          ? () => quizProvider.previousQuestion()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.white24 : AppTheme.lightPink,
                        disabledBackgroundColor: isDark ? Colors.white10 : Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          color: isDark ? Colors.white : AppTheme.darkGreen,
                          fontSize: 16 * fontScale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: quizProvider.selectedAnswers.containsKey(quizProvider.currentQuestionIndex)
                          ? (quizProvider.currentQuestionIndex == quizProvider.questions.length - 1
                          ? () => _submitQuiz(context)
                          : () => quizProvider.nextQuestion())
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.lightGreen,
                        disabledBackgroundColor: isDark ? Colors.white10 : Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: quizProvider.selectedAnswers.containsKey(quizProvider.currentQuestionIndex) ? 2 : 0,
                      ),
                      child: Text(
                        quizProvider.currentQuestionIndex == quizProvider.questions.length - 1 ? 'Submit' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * fontScale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
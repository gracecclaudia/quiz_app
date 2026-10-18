import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';
import 'welcome_screen.dart';

class PreparationScreen extends StatefulWidget {
  const PreparationScreen({super.key});

  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
  // opsi dropdown mata kuliah
  final List<String> categories = [
    "Kriptografi",
    "Human Computer Interaction",
    "Grafika Komputer",
    "Komputasi Paralel dan Terdistribusi",
    "Metodologi Penelitian",
    "Cloud Computing",
    "Pemrograman Mobile",
  ];

  String selectedCategory = "Kriptografi";
  String selectedDifficulty = "Campuran";
  int selectedQuestionCount = 5;

  void _startQuiz() {
    Provider.of<QuizProvider>(context, listen: false)
        .prepareQuiz(selectedCategory, selectedDifficulty, selectedQuestionCount);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  }

  // pop-up konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Change User / Logout?',
          style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to change user? You will return to the welcome screen.',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // tutup dialog, batal logout
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(); // tutup dialog

              // hapus user dan kembali ke WelcomeScreen
              Provider.of<QuizProvider>(context, listen: false).clearUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
            child: const Text('Yes, Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<QuizProvider>(context, listen: false).userName;

    return Scaffold(
      backgroundColor: AppTheme.lightPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Quiz Setup',
          style: TextStyle(
            color: AppTheme.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppTheme.darkGreen),
            tooltip: 'Change User',
            // memanggil dialog konfirmasi saat tombol logout dipencet
            onPressed: () => _showLogoutDialog(context),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $userName! 👋',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Let\'s customize your quiz session.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.darkGreen.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 30),

              // container putih
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryPink.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // matkul
                        const Text(
                          'Course Category',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkGreen),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFAFAFA),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.lightPink)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.lightPink)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.lightGreen, width: 2)),
                          ),
                          items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                          onChanged: (val) => setState(() => selectedCategory = val!),
                        ),
                        const SizedBox(height: 25),

                        // tingkat kesulitan
                        const Text(
                          'Difficulty Level',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkGreen),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: ["Campuran", "Mudah", "Sedang", "Sulit"].map((diff) {
                            final isSelected = selectedDifficulty == diff;
                            return ChoiceChip(
                              label: Text(diff),
                              selected: isSelected,
                              showCheckmark: false,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              onSelected: (selected) => setState(() => selectedDifficulty = diff),
                              selectedColor: AppTheme.lightGreen,
                              backgroundColor: const Color(0xFFFAFAFA),
                              labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : AppTheme.darkGreen,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                              ),
                              side: BorderSide(color: isSelected ? AppTheme.lightGreen : AppTheme.lightPink),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 25),

                        // jumlah soal
                        const Text(
                          'Number of Questions',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkGreen),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 15,
                          children: [3, 5, 7].map((count) {
                            final isSelected = selectedQuestionCount == count;
                            return ChoiceChip(
                              label: Text('$count'),
                              selected: isSelected,
                              showCheckmark: false,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              onSelected: (selected) => setState(() => selectedQuestionCount = count),
                              selectedColor: AppTheme.lightGreen,
                              backgroundColor: const Color(0xFFFAFAFA),
                              labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : AppTheme.darkGreen,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                              ),
                              side: BorderSide(color: isSelected ? AppTheme.lightGreen : AppTheme.lightPink),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ready
              PrimaryButton(
                text: 'Ready!',
                onPressed: _startQuiz,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
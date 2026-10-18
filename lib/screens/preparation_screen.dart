import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';
import 'welcome_screen.dart';
import 'settings_screen.dart';

class PreparationScreen extends StatefulWidget {
  const PreparationScreen({super.key});

  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
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

  void _showLogoutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Change User / Logout?',
          style: TextStyle(
            color: isDark ? Colors.white : AppTheme.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to change user? You will return to the welcome screen.',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
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

  // widget helper untuk scroll horizontal
  Widget _buildDifficultySelector(bool isDark) {
    final diffs = ["Campuran", "Mudah", "Sedang", "Sulit"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: diffs.map((diff) {
          final isSelected = selectedDifficulty == diff;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(diff),
              selected: isSelected,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              onSelected: (selected) => setState(() => selectedDifficulty = diff),
              selectedColor: AppTheme.lightGreen,
              backgroundColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFAFAFA),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppTheme.darkGreen),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.lightGreen : (isDark ? Colors.white24 : AppTheme.lightPink),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuestionCountSelector(bool isDark, bool isDesktopOrTablet) {
    final counts = [3, 5, 7];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: counts.map((count) {
          final isSelected = selectedQuestionCount == count;
          // di layar web, tampilkan "5 Questions". di HP, tampilkan angka "5" saja agar muat
          final labelText = isDesktopOrTablet ? '$count Questions' : '$count';
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(labelText),
              selected: isSelected,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              onSelected: (selected) => setState(() => selectedQuestionCount = count),
              selectedColor: AppTheme.lightGreen,
              backgroundColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFAFAFA),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppTheme.darkGreen),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.lightGreen : (isDark ? Colors.white24 : AppTheme.lightPink),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final userName = quizProvider.userName;
    final isDark = quizProvider.isDarkMode;

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktopOrTablet = screenWidth > 768;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : AppTheme.lightPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Semester 5 Quiz',
          style: TextStyle(
            fontFamily: 'MountainsOfChristmas',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppTheme.darkGreen,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: isDark ? Colors.white : AppTheme.darkGreen,
            ),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: isDark ? Colors.white70 : AppTheme.darkGreen,
            ),
            tooltip: 'Change User',
            onPressed: () => _showLogoutDialog(context, isDark),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktopOrTablet ? 750 : double.infinity,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktopOrTablet ? 40 : 25,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // bagian header sapaan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $userName! 👋',
                          style: TextStyle(
                            fontSize: isDesktopOrTablet ? 30 : 26,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppTheme.darkGreen,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Let\'s customize your quiz session.',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white70 : AppTheme.darkGreen.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                    if (isDesktopOrTablet)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGreen.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '💻 Web / Tablet Mode',
                          style: TextStyle(color: AppTheme.lightGreen, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 25),

                // kontainer utama form
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isDesktopOrTablet ? 35 : 25),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryPink.withValues(alpha: isDark ? 0.0 : 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Course Category
                          Text(
                            'Course Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : AppTheme.darkGreen),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: selectedCategory,
                            isExpanded: true,
                            dropdownColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                            style: TextStyle(color: isDark ? Colors.white : AppTheme.darkGreen, fontFamily: 'Poppins'),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFAFAFA),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.lightPink)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: isDark ? Colors.white24 : AppTheme.lightPink)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.lightGreen, width: 2)),
                            ),
                            items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                            onChanged: (val) => setState(() => selectedCategory = val!),
                          ),
                          const SizedBox(height: 25),

                          // Difficulty Level
                          Text(
                            'Difficulty Level',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : AppTheme.darkGreen),
                          ),
                          const SizedBox(height: 10),
                          _buildDifficultySelector(isDark),

                          const SizedBox(height: 25),

                          // Number of Questions
                          Text(
                            'Number of Questions',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : AppTheme.darkGreen),
                          ),
                          const SizedBox(height: 10),
                          _buildQuestionCountSelector(isDark, isDesktopOrTablet),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // tombol mulai
                PrimaryButton(
                  text: 'Ready!',
                  onPressed: _startQuiz,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
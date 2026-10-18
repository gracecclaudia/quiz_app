import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import 'preparation_screen.dart'; // <-- Ubah import ini ke preparation_screen

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameFilled = false; // status apakah teks sudah diisi

  @override
  void initState() {
    super.initState();
    // memantau setiap ketikan keyboard
    _nameController.addListener(() {
      setState(() {
        // cek apakah kolom input tidak kosong (spasi saja tidak dihitung)
        _isNameFilled = _nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    final name = _nameController.text.trim();

    // Validasi keamanan tambahan (meski tombol sudah disable jika kosong)
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name first! 🌸'),
          backgroundColor: AppTheme.primaryPink,
        ),
      );
      return;
    }

    // Simpan nama ke provider
    Provider.of<QuizProvider>(context, listen: false).setUserName(name);

    // Navigasi Pindah ke PreparationScreen (BUKAN langsung ke QuizScreen)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PreparationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightPink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_florist,
                  size: 80,
                  color: AppTheme.lightGreen,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme.darkGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Quiz Time!',
                  style: TextStyle(
                    fontFamily: 'MountainsOfChristmas',
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightGreen,
                  ),
                ),
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryPink.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What is your name?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Type here...',
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 25),

                      PrimaryButton(
                        text: 'Start Quiz',
                        // jika _isNameFilled false, tombol otomatis menjadi mati (abu-abu)
                        onPressed: _isNameFilled ? _startQuiz : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
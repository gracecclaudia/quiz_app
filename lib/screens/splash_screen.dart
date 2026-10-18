import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // splash screen 2.5 detik
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // transisi splash
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const TransitionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500), // fade in ke layar yg hijau
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightPink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_florist,
              size: 100,
              color: AppTheme.lightGreen,
            ),
            const SizedBox(height: 20),
            // font mountains of christmas
            const Text(
              'Quiz Time!',
              style: TextStyle(
                fontFamily: 'MountainsOfChristmas',
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGreen,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.lightGreen),
            ),
          ],
        ),
      ),
    );
  }
}

// widget untuk layar kosong transisi
class TransitionScreen extends StatefulWidget {
  const TransitionScreen({super.key});

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  void initState() {
    super.initState();
    // setelah 0.6 detik di layar hijau, pindah ke welcome wcreen
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600), // fade in ke welcome screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // layar transisi
    return const Scaffold(
      backgroundColor: AppTheme.lightGreen,
    );
  }
}
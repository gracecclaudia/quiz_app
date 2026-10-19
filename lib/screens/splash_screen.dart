import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // durasi animasi bunganya mekar (0.8 detik)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // animasi bunga membesar (menutupi layar)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 50.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // animasi memudarkan teks "Quiz Time!" dan loading
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // tahan di layar splash statis selama 2 detik
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    // mulai animasi bunga mekar menutupi layar
    await _controller.forward();
    if (!mounted) return;

    // metelah layar tertutup hijau (bunga mekar), pindah ke WelcomeScreen
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
        transitionDuration: const Duration(milliseconds: 1200), // Transisi sangat smooth
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightPink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // animasi bunga mekar
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // lingkaran hijau di belakang bunga
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _controller.value > 0.05
                              ? AppTheme.lightGreen
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // bunga florist
                      Icon(
                        Icons.local_florist,
                        size: 100,
                        color: _controller.value > 0.05
                            ? Colors.white.withValues(alpha: 0.3)
                            : AppTheme.lightGreen,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20), // Jarak antara bunga dan teks

            // teks dan loading
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
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
          ],
        ),
      ),
    );
  }
}
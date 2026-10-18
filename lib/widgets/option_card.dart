import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionCard({
    super.key,
    required this.optionText,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<QuizProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightGreen.withValues(alpha: 0.15)
              : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppTheme.lightGreen : (isDark ? Colors.white24 : AppTheme.lightPink),
            width: isSelected ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryPink.withValues(alpha: isDark ? 0.0 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? AppTheme.lightGreen : (isDark ? Colors.white70 : AppTheme.darkGreen),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? AppTheme.lightGreen : (isDark ? Colors.white : AppTheme.darkGreen),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
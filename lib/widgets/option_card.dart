import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final VoidCallback onTap;
  final bool isSelected; // parameter untuk status terpilih

  const OptionCard({
    super.key,
    required this.optionText,
    required this.onTap,
    this.isSelected = false, // default, jawaban belum dipilih
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          // warna latar belakang menjadi hijau transparan klo dipilih
          color: isSelected ? AppTheme.lightGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          // border kotak menjadi hijau klo dipilih
          border: Border.all(
            color: isSelected ? AppTheme.lightGreen : AppTheme.lightPink,
            width: isSelected ? 2.0 : 1.5, // Garisnya sedikit lebih tebal kalau dipilih
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryPink.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            //ikon lingkaran kosong  menjadi lingkaran terisi centang hijau klo dipilih
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: AppTheme.lightGreen,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 16,
                  // warna teks hijau
                  color: isSelected ? AppTheme.lightGreen : AppTheme.darkGreen,
                  // teks bold kalau dipilih
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
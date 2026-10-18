import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 480, // lebar maksimum kayak ukuran layar HP di web/tablet
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width > 480 ? 20 : 0,
          ),
          child: Scaffold(
            body: child,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TypeWidg extends StatelessWidget {
  const TypeWidg({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.3),
         borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            name,
            style: TextStyle(color: Colors.white,
             fontWeight: FontWeight.bold,
              fontSize: 12),
          ),
        ),
      ),
    );
  }
}

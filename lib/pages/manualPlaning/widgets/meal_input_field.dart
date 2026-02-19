import 'package:flutter/material.dart';

class MealInputTile extends StatelessWidget {
  final String label;
  final IconData icon;

  const MealInputTile({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4CAF50)),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '$label meal (optional)',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

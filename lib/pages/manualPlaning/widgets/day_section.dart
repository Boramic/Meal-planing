import 'package:flutter/material.dart';
import 'meal_input_field.dart';

class DaySection extends StatefulWidget {
  final String day;
  const DaySection({super.key, required this.day});

  @override
  State<DaySection> createState() => _DaySectionState();
}

class _DaySectionState extends State<DaySection> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => expanded = !expanded),
            child: Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: Color(0xFF4CAF50)),
                const SizedBox(width: 10),
                Text(
                  widget.day,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(
                  expanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          if (expanded) ...[
            const SizedBox(height: 16),
            const MealInputTile(
              icon: Icons.wb_sunny,
              label: 'Morning',
            ),
            const MealInputTile(
              icon: Icons.restaurant,
              label: 'Afternoon',
            ),
            const MealInputTile(
              icon: Icons.nights_stay,
              label: 'Night',
            ),
          ],
        ],
      ),
    );
  }
}

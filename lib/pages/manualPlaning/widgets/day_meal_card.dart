import 'package:flutter/material.dart';
import 'meal_input_field.dart';

class DayMealCard extends StatelessWidget {
  final String day;

  const DayMealCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 12),

            const MealInputField(label: 'Morning Meal'),
            const MealInputField(label: 'Afternoon Meal'),
            const MealInputField(label: 'Night Meal'),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../data/models/meal_plan_model.dart';

class DayPlanningCard extends StatelessWidget {
  final MealPlan plan;

  const DayPlanningCard({super.key, required this.plan});

  Widget _mealRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2E7D32)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DAY TITLE
            Text(
              plan.day,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const Divider(height: 22),

            if (plan.morning != null)
              _mealRow(Icons.wb_sunny, 'Morning', plan.morning!),

            if (plan.afternoon != null)
              _mealRow(Icons.lunch_dining, 'Afternoon', plan.afternoon!),

            if (plan.night != null)
              _mealRow(Icons.nights_stay, 'Night', plan.night!),
          ],
        ),
      ),
    );
  }
}

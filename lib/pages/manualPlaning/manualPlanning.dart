import 'package:flutter/material.dart';
import 'widgets/day_section.dart';
import '../../core/routes/app_routes.dart';

class ManualPlanningPage extends StatelessWidget {
  const ManualPlanningPage({super.key});

  static const days = [
    'Monday','Tuesday','Wednesday',
    'Thursday','Friday','Saturday','Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Plan Your Week',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// 🌿 INTRO
          const Text(
            'Choose meals freely.\nOne, two or three meals per day.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          /// 📅 DAYS
          ...days.map((day) => DaySection(day: day)),

          const SizedBox(height: 30),

          /// 💾 SAVE
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.viewPlanning);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Save My Weekly Plan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

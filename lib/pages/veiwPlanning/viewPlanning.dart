import 'package:flutter/material.dart';
import '../../data/models/meal_plan_model.dart';
import 'widgets/day_planning_card.dart';
import 'widgets/recommendation_section.dart';

class ViewPlanningPage extends StatelessWidget {
  const ViewPlanningPage({super.key});

  /// TEMP DATA (later replaced by Firebase)
  List<MealPlan> get weeklyPlan => [
    MealPlan(
      day: 'Monday',
      morning: 'Omelette & Bread',
      afternoon: 'Rice and Chicken',
      night: 'Vegetable Soup',
    ),
    MealPlan(
      day: 'Tuesday',
      morning: 'Porridge',
      afternoon: 'Beans & Plantain',
    ),
    MealPlan(
      day: 'Wednesday',
      afternoon: 'Spaghetti',
      night: 'Grilled Fish',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      /// APP BAR
      appBar: AppBar(
        title: const Text(
          'Weekly Planning',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 6,
      ),

      /// BODY
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// WEEK CARDS
          ...weeklyPlan.map(
                (plan) => DayPlanningCard(plan: plan),
          ),

          const SizedBox(height: 30),

          /// RECOMMENDATION AREA
          const RecommendationSection(),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RecommendationSection extends StatefulWidget {
  const RecommendationSection({super.key});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '🍽️ Cooking Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 12),
            Text('• Wash hands before cooking'),
            Text('• Use fresh ingredients'),
            Text('• Store food properly'),
            Text('• Respect meal time balance'),
            Text('• Drink enough water'),
          ],
        ),
      ),
    );
  }
}

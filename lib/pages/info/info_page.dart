import 'package:flutter/material.dart';
import '../widgets/home_footer.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
        title: const Text(
          'About Meal Planning',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🌿 HERO HEADER
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32),
                    const Color(0xFF43A047),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu,
                        color: Colors.white, size: 56),
                    SizedBox(height: 10),
                    Text(
                      'Plan Smart • Eat Better',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 📘 ABOUT CARD
            _infoCard(
              icon: Icons.info_outline,
              title: 'What is Meal Planning?',
              content:
              'Meal Planning helps you organize your meals based on your '
                  'budget, health condition, preferences, and lifestyle. '
                  'It ensures balanced nutrition while saving time and money.',
            ),

            /// ⚙ HOW IT WORKS
            _infoCard(
              icon: Icons.settings,
              title: 'How it Works',
              content:
              '1. Register your personal details\n'
                  '2. Set your budget and preferences\n'
                  '3. Generate a personalized meal plan\n'
                  '4. Follow your plan and market list easily',
            ),

            /// ❤️ WHY USE IT
            _infoCard(
              icon: Icons.favorite_outline,
              title: 'Why Use This App?',
              content:
              '• Helps manage food expenses\n'
                  '• Improves healthy eating habits\n'
                  '• Saves time planning meals\n'
                  '• Suitable for families & individuals\n'
                  '• Adapts to medical conditions',
            ),

            const SizedBox(height: 20),

            /// ⬇ FOOTER
            const HomeFooter(),
          ],
        ),
      ),
    );
  }

  /// ♻ REUSABLE INFO CARD
  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF2E7D32), size: 30),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

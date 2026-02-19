import 'package:flutter/material.dart';
import '../widgets/home_action_card.dart';
import '../widgets/home_footer.dart';
import '../widgets/home_image_carousel.dart';
import '../../core/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
        title: const Text(
          'Meal Planning',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        /// ☰ DROPDOWN MENU
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onSelected: (value) {
              if (value == 'register') {
                Navigator.pushNamed(context, AppRoutes.registration);
              } else if (value == 'login') {
                Navigator.pushNamed(context, AppRoutes.login);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'register',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Registration'),
                ),
              ),
              const PopupMenuItem(
                value: 'login',
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Login'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About'),
                ),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          /// 🔳 GRID BUTTONS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.35,
                children: const [
                  HomeActionCard(
                    icon: Icons.edit_calendar,
                    title: 'Do your planning',
                    routeName: '/manualPlanning',
                  ),
                  HomeActionCard(
                    icon: Icons.auto_awesome,
                    title: 'Automatically generate',
                    routeName: '/autoPlanning',
                  ),
                  HomeActionCard(
                    icon: Icons.shopping_cart,
                    title: 'Make your market list',
                    routeName: '/marketList',
                  ),
                  HomeActionCard(
                    icon: Icons.view_list,
                    title: 'View your planning',
                    routeName: '/viewPlanning',
                  ),
                ],
              ),
            ),
          ),

          /// 🖼️ IMAGE CAROUSEL (ONLY THIS LINE)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HomeImageCarousel(),
          ),

          const SizedBox(height: 10),

          /// ⬇️ FOOTER
          const HomeFooter(),
        ],
      ),
    );
  }
}

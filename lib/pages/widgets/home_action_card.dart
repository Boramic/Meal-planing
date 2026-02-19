import 'dart:ui';
import 'package:flutter/material.dart';

class HomeActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;

  const HomeActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            /// Glass background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.95),
                    Colors.green.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            /// Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.8),
              child: Container(
                color: Colors.white.withOpacity(0.04),
              ),
            ),

            /// Content
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 24),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2, // 🔧 prevents overflow
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
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

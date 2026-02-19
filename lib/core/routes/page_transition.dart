import 'package:flutter/material.dart';

class ScaleFadeRoute extends PageRouteBuilder {
  final Widget page;

  ScaleFadeRoute({required this.page})
      : super(
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
      );

      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

      return FadeTransition(
        opacity: fade,
        child: ScaleTransition(
          scale: scale,
          child: child,
        ),
      );
    },
  );
}
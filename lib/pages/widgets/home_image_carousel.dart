import 'dart:async';
import 'package:flutter/material.dart';

class HomeImageCarousel extends StatefulWidget {
  const HomeImageCarousel({super.key});

  @override
  State<HomeImageCarousel> createState() => _HomeImageCarouselState();
}

class _HomeImageCarouselState extends State<HomeImageCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<String> images = [
    'images/image 1.jpg',
    'images/image 2.jpg',
    'images/image 3.jpg',
    'images/image 4.jpg',
    'images/image 5.jpg',
  ];
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    /// 🔁 AUTO SLIDE
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        _currentIndex = (_currentIndex + 1) % images.length;
        _controller.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          /// 🖼️ CAROUSEL
          SizedBox(
            height: 160,
            width: double.infinity,
            child: PageView.builder(
              controller: _controller,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          /// 🌿 SOFT OVERLAY (same style as before)
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          /// 📝 TEXT
          const Positioned(
            left: 16,
            bottom: 16,
            child: Text(
              'Plan smarter\nEat better',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// ⚪ INDICATORS
          Positioned(
            bottom: 10,
            right: 16,
            child: Row(
              children: List.generate(
                images.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == index ? 10 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
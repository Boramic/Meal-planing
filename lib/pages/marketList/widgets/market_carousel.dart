import 'package:flutter/material.dart';

class MarketCarousel extends StatelessWidget {
  const MarketCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: PageView(
        children: const [
          _ImageCard('images/image 1.jpg'),
          _ImageCard('images/image 2.jpg'),
          _ImageCard('images/image 3.jpg'),
          _ImageCard('images/image 4.jpg'),
          _ImageCard('images/image 5.jpg'),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final String image;
  const _ImageCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
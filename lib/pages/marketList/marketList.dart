import 'package:flutter/material.dart';
import '../../data/models/market_item_model.dart';
import 'widgets/add_item_card.dart';
import 'widgets/market_item_card.dart';
import 'widgets/market_carousel.dart';

class MarketListPage extends StatefulWidget {
  const MarketListPage({super.key});

  @override
  State<MarketListPage> createState() => _MarketListPageState();
}

class _MarketListPageState extends State<MarketListPage> {
  final List<MarketItem> items = [];

  void addItem(MarketItem item) {
    setState(() => items.add(item));
  }

  void deleteItem(int index) {
    setState(() => items.removeAt(index));
  }

  void togglePurchased(int index) {
    setState(() => items[index].purchased = !items[index].purchased);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF7),
      appBar: AppBar(
        title: const Text('Market List',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 6,
      ),
      body: Column(
        children: [
          const MarketCarousel(),

          AddItemCard(onAdd: addItem),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MarketItemCard(
                  item: items[index],
                  onDelete: () => deleteItem(index),
                  onToggle: () => togglePurchased(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

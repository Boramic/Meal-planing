import 'package:flutter/material.dart';
import '../../../data/models/market_item_model.dart';

class MarketItemCard extends StatelessWidget {
  final MarketItem item;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const MarketItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: item.purchased ? 0.5 : 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          leading: Checkbox(
            value: item.purchased,
            activeColor: const Color(0xFF4CAF50),
            onChanged: (_) => onToggle(),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration:
              item.purchased ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text('${item.price.toStringAsFixed(0)} FCFA'),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
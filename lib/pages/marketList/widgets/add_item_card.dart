import 'package:flutter/material.dart';
import '../../../data/models/market_item_model.dart';

class AddItemCard extends StatefulWidget {
  final Function(MarketItem) onAdd;
  const AddItemCard({super.key, required this.onAdd});

  @override
  State<AddItemCard> createState() => _AddItemCardState();
}

class _AddItemCardState extends State<AddItemCard> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.shopping_bag),
                labelText: 'Item name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Price',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Item',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty) return;
                widget.onAdd(
                  MarketItem(
                    name: nameCtrl.text,
                    price: double.parse(priceCtrl.text),
                  ),
                );
                nameCtrl.clear();
                priceCtrl.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
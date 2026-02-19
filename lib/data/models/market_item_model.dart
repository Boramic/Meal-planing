class MarketItem {
  String name;
  double price;
  bool purchased;

  MarketItem({
    required this.name,
    required this.price,
    this.purchased = false,
  });
}

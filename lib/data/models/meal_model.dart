class Meal {
  final String name;
  final String type; // breakfast, lunch, dinner
  final int sugar;
  final int cholesterol;
  final int salt;
  final int calories;
  final List<String> tags;

  Meal({
    required this.name,
    required this.type,
    required this.sugar,
    required this.cholesterol,
    required this.salt,
    required this.calories,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'sugar': sugar,
      'cholesterol': cholesterol,
      'salt': salt,
      'calories': calories,
      'tags': tags,
    };
  }
}
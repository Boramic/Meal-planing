import 'package:cloud_firestore/cloud_firestore.dart';
import '../cameroon_meals.dart';

class MealUploader {
  static Future<void> uploadMeals() async {
    final firestore = FirebaseFirestore.instance;

    for (final meal in cameroonMeals) {
      await firestore.collection('meals').add(meal.toMap());
    }

    print('✅ Cameroon meals uploaded successfully');
  }
}
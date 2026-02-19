import 'package:flutter/material.dart';
import '../widgets/home_footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  String? fullName;
  int? age;
  double? budget;
  String gender = 'Male';
  String dietType = 'Omnivore';
  String activityLevel = 'Moderate';

  List<String> healthConditions = [];

  final List<String> conditionsList = [
    'Diabetes',
    'Hypertension',
    'Obesity',
    'Anemia',
    'Ulcer',
    'Lactose intolerance',
    'Gluten intolerance',
    'Kidney disease',
    'Heart disease',
    'Food allergies',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🍽️ HERO IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/healthy_food.jpg',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle('Personal Information'),

                    _inputField(
                      icon: Icons.person,
                      label: 'Full Name',
                      onSaved: (value) => fullName = value,
                    ),

                    _inputField(
                      icon: Icons.cake,
                      label: 'Age',
                      keyboard: TextInputType.number,
                      onSaved: (value) => age = int.tryParse(value!),
                    ),

                    _dropdown(
                      icon: Icons.wc,
                      label: 'Gender',
                      value: gender,
                      items: ['Male', 'Female', 'Other'],
                      onChanged: (value) => setState(() => gender = value!),
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle('Health Conditions'),

                    Wrap(
                      spacing: 10,
                      children: conditionsList.map((condition) {
                        final selected = healthConditions.contains(condition);
                        return FilterChip(
                          label: Text(condition),
                          selected: selected,
                          selectedColor: Colors.green.shade200,
                          onSelected: (bool value) {
                            setState(() {
                              value
                                  ? healthConditions.add(condition)
                                  : healthConditions.remove(condition);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle('Food Preferences'),

                    _dropdown(
                      icon: Icons.restaurant,
                      label: 'Diet Type',
                      value: dietType,
                      items: [
                        'Omnivore',
                        'Vegetarian',
                        'Vegan',
                        'Pescatarian',
                        'Halal',
                        'Kosher'
                      ],
                      onChanged: (value) =>
                          setState(() => dietType = value!),
                    ),

                    _dropdown(
                      icon: Icons.directions_run,
                      label: 'Activity Level',
                      value: activityLevel,
                      items: ['Sedentary', 'Moderate', 'Active'],
                      onChanged: (value) =>
                          setState(() => activityLevel = value!),
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle('Budget'),

                    _inputField(
                      icon: Icons.attach_money,
                      label: 'Monthly Food Budget',
                      keyboard: TextInputType.number,
                      onSaved: (value) =>
                      budget = double.tryParse(value!),
                    ),

                    const SizedBox(height: 30),

                    /// ✅ SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Save & Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: _submitForm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// ⬇️ FOOTER
          const HomeFooter(),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final user = _auth.currentUser;

        if (user != null) {
          final uid = user.uid;

          await _firestore.collection('users').doc(uid).update({
            'age': age,
            'gender': gender,
            'dietType': dietType,
            'activityLevel': activityLevel,
            'budget': budget,
            'healthConditions': healthConditions,
          });

          // Navigate to next page (e.g., Home or Meal Planner)
          Navigator.pushReplacementNamed(context, '/home');

        } else {
          // Should not happen, user must be logged in
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No logged in user found')),
          );
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Failed to save user data')),
        );
      }
    }
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2E7D32),
        ),
      ),
    );
  }

  Widget _inputField({
    required IconData icon,
    required String label,
    TextInputType keyboard = TextInputType.text,
    required Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        keyboardType: keyboard,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? 'Required' : null,
        onSaved: onSaved,
      ),
    );
  }

  Widget _dropdown({
    required IconData icon,
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

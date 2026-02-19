import 'package:flutter/material.dart';
import '../widgets/auth_input.dart';
import '../../core/routes/app_routes.dart';
import '../../core/routes/page_transition.dart';
import 'auth_success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool agreed = false;
  bool hidePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              const Center(
                child: Icon(Icons.restaurant_menu,
                    size: 60, color: Color(0xFF2E7D32)),
              ),

              const SizedBox(height: 20),
              const Text(
                'Sign up to continue!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),


              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthInput(
                      label: 'Full Name',
                      icon: Icons.person,
                      controller: nameCtrl,
                    ),
                    const SizedBox(height: 14),
                    AuthInput(
                      label: 'Email Address',
                      icon: Icons.email,
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 14),
                    AuthInput(
                      label: 'Password',
                      icon: Icons.lock,
                      controller: passwordCtrl,
                      obscure: hidePassword,
                      suffix: IconButton(
                        icon: Icon(hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => hidePassword = !hidePassword),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    value: agreed,
                    onChanged: (v) => setState(() => agreed = v!),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms of Service & Privacy Policy',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),

              ElevatedButton(
                onPressed: agreed
                    ? () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final userCredential =
                      await _auth.createUserWithEmailAndPassword(
                        email: emailCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                      );

                      final uid = userCredential.user!.uid;

                      // Create user document in Firestore
                      await _firestore.collection('users').doc(uid).set({
                        'fullName': nameCtrl.text.trim(),
                        'email': emailCtrl.text.trim(),
                        'createdAt': Timestamp.now(),
                        'lastLogin': Timestamp.now(),
                      });

                      Navigator.pushReplacement(
                        context,
                        ScaleFadeRoute(
                          page: const AuthSuccessPage(
                            message: 'Account created successfully',
                          ),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Signup failed')),
                      );
                    }
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('SIGN UP'),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account? '),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
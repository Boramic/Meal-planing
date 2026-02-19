import 'package:flutter/material.dart';
import '../widgets/auth_input.dart';
import '../widgets/social_button.dart';
import '../../core/routes/app_routes.dart';
import '../../core/routes/page_transition.dart';
import 'auth_success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    checkEmailLink(); // 🔹 Check if app opened from email link
  }

  /// 🔹 Function to handle email link login
  void checkEmailLink() async {
    final auth = FirebaseAuth.instance;
    final uri = Uri.base.toString();

    if (auth.isSignInWithEmailLink(uri)) {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('emailForSignIn');

      if (email != null) {
        try {
          final userCredential = await auth.signInWithEmailLink(
            email: email,
            emailLink: uri,
          );

          final uid = userCredential.user!.uid;

          // Update last login in Firestore
          await _firestore.collection('users').doc(uid).update({
            'lastLogin': Timestamp.now(),
          });

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthSuccessPage(
                message: 'Login successful!',
              ),
            ),
          );
        } catch (e) {
          print('Error signing in with email link: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error signing in: $e')),
            );
          }
        }
      }
    }
  }

  /// 🔹 Function to send login link to email
  Future<void> sendSignInLink(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailForSignIn', email);

    final acs = ActionCodeSettings(
      url: 'https://YOUR_APP_URL', // Replace with your app URL
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios', // Replace with your iOS bundle ID
      androidPackageName: 'com.example.android', // Replace with your Android package name
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check your email to complete login!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending email link: $e')),
      );
    }
  }

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
              const SizedBox(height: 40),

              /// 🍽️ LOGO
              Column(
                children: const [
                  Icon(Icons.restaurant_menu,
                      size: 64, color: Color(0xFF2E7D32)),
                  SizedBox(height: 8),
                  Text(
                    'Meal Planning',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                'Welcome 👋',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter email or phone number to continue',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: AuthInput(
                  label: 'Email or Phone',
                  icon: Icons.email,
                  controller: emailController,
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final userCredential =
                        await _auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: "TEMP_PASSWORD", // we will improve later
                        );

                        final uid = userCredential.user!.uid;

                        // Update last login
                        await _firestore.collection('users').doc(uid).update({
                          'lastLogin': Timestamp.now(),
                        });

                        Navigator.pushReplacement(
                          context,
                          ScaleFadeRoute(
                            page: const AuthSuccessPage(
                              message: 'Login successful',
                            ),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? 'Login failed')),
                        );
                      }
                    }
                  },
                child: const Text('CONTINUE'),
              ),

              const SizedBox(height: 20),
              const Center(child: Text('or continue with')),
              const SizedBox(height: 16),

              SocialButton(
                text: 'Google',
                icon: Icons.g_mobiledata,
                onTap: () {},
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.signup),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
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
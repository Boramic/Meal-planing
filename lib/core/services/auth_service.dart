import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// 🔐 SIGN UP
  Future<User?> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      await _db.collection('users').doc(user.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  /// 🔑 LOGIN
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _db.collection('users').doc(userCredential.user!.uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });

    return userCredential.user;
  }

  /// 🚪 LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// 👀 CURRENT USER
  User? get currentUser => _auth.currentUser;
}
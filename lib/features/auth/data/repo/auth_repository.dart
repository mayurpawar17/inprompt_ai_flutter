import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();

  Future<User> signIn({required String email, required String password}) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user!;

    // 2️⃣ Store user profile in Firestore
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

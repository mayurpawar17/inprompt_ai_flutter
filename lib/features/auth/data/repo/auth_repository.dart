import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();

  Future<User> signIn({required String email, required String password}) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  Future<User> signUp({required String email, required String password}) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

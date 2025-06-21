import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/domain/repositories/auth_repository.dart';

// FirebaseのAuthの状態を取得
class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  @override
  Future<UserCredential> signIn({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> deleteUser() async {
    // currentUserがnullでないことを確認
    if (_auth.currentUser == null) {
      throw Exception('No user is currently signed in.');
    } else {
      await _auth.currentUser!.delete();
    }

  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/domain/entities/auth_result_entity.dart';
import 'package:flutter_workout_manager/domain/entities/user_entity.dart';
import 'package:flutter_workout_manager/domain/repositories/auth_repository.dart';

// FirebaseのAuthの状態を取得
class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<UserEntity?> authStateChanges() {
    return _auth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserEntity(uid: firebaseUser.uid, email: firebaseUser.email);
    });
  }

  @override
  Future<AuthResultEntity> signIn({required String email, required String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception('Sign in failed: User credential is null');
    }
    return AuthResultEntity(
      user: UserEntity(uid: firebaseUser.uid, email: firebaseUser.email),
    );
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

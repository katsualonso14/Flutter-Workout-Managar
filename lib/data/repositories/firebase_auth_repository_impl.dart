import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/domain/repositories/auth_repository.dart';

// FirebaseのAuthの状態を取得
class FirebaseAuthRepositoryImpl implements AuthRepository {
  @override
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}

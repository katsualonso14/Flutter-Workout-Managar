import 'package:flutter_workout_manager/domain/entities/auth_result_entity.dart';
import 'package:flutter_workout_manager/domain/entities/user_entity.dart';

// FirebaseAuthのData層とPresentation層の間のインターフェース
abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  Future<AuthResultEntity> signIn({required String email, required String password});
  Future<void> deleteUser();
}
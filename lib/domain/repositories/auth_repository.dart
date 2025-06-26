import 'package:flutter_workout_manager/domain/entities/user_entity.dart';

// FirebaseAuthのData層とPresentation層の間のインターフェース
abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> register({required String email, required String password});
  Future<void> deleteUser();
}
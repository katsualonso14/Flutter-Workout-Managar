import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/repositories/firebase_auth_repository_impl.dart';
import 'package:flutter_workout_manager/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepositoryImpl();
});
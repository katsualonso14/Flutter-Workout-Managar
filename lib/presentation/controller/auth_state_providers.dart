import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/data/repositories/firebase_auth_repository_impl.dart';
import 'package:flutter_workout_manager/domain/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepositoryImpl();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

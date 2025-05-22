import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Userチェック
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

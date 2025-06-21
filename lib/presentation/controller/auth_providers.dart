import 'package:flutter_workout_manager/domain/entities/user_entity.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Userチェック
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

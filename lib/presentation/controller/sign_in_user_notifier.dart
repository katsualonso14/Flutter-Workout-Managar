import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';

final signInUserNotifierProvider = AsyncNotifierProvider<SignInUserNotifier, void>(() {
  return SignInUserNotifier();
});

class SignInUserNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {} // 使わない

  Future<void> signIn(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    try {
      await repository.signIn(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

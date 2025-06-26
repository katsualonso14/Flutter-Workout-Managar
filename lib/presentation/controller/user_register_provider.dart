
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';

final userRegisterProvider = AsyncNotifierProvider<UserRegisterNotifier, void>(() {
  return UserRegisterNotifier();
});

class UserRegisterNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {} // 初期処理はないので空

  Future<void> registerUser(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    try {
      await repository.register(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
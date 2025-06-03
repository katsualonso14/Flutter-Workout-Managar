import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';

class DeleteUserNotifier extends AsyncNotifier<void> {
  @override
  // 初期処理がないので空
  Future<void> build() async {}

  Future<void> deleteUser() async {
    state = const AsyncLoading();
    final repository = ref.read(authRepositoryProvider);
    try {
      await repository.deleteUser();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

final deleteUserNotifierProvider = AsyncNotifierProvider<DeleteUserNotifier, void>(DeleteUserNotifier.new);

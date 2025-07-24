// TODO: 下記を参考に新しいGerenatorを使うやり方で修正
//https://stackoverflow.com/questions/70516583/mockito-mocked-function-returned-null
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workout_manager/domain/entities/user_entity.dart';
import 'package:flutter_workout_manager/domain/providers/auth_repository_provider.dart';
import 'package:flutter_workout_manager/presentation/controller/sign_in_user_notifier.dart';
import 'package:mockito/mockito.dart';

import '../test_helper/auth_repository.mocks.dart';

void main() {
  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockAuthRepository();

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('signIn成功時は状態がAsyncLoading→AsyncDataに変わる', () async {
    // signInが成功するようにセット
    when(mockRepository.signIn(email: 'test@example.com', password: 'password'))
        .thenAnswer((_) async =>
            UserEntity(uid: 'test_uid', email: 'test@example.com'));

    final notifier = container.read(signInUserNotifierProvider.notifier);
    final future = notifier.signIn('test@example.com', 'pass123');

    // stateがAsyncLoadingになることを確認
    expect(notifier.state, isA<AsyncLoading>());

    await future;

    // stateがAsyncData(null)になることを確認
    expect(notifier.state, isA<AsyncData<void>>());
  });

  test('signIn失敗時は状態がAsyncLoading→AsyncErrorに変わる', () async {
    // signInが例外を投げるようにセット
    final exception = Exception('sign in failed');
    when(mockRepository.signIn(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(exception);

    final notifier = container.read(signInUserNotifierProvider.notifier);

    expect(
      () => notifier.signIn('test@example.com', 'password'),
      throwsA(exception),
    );

    // stateがAsyncErrorになることを確認
    expect(notifier.state, isA<AsyncError>());
  });
}

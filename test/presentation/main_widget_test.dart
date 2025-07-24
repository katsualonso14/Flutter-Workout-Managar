import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workout_manager/domain/entities/user_entity.dart';
import 'package:flutter_workout_manager/main.dart';
import 'package:flutter_workout_manager/presentation/controller/auth_providers.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'package:flutter_workout_manager/presentation/widgets/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/entities/test_user.dart';
import '../test_helper/mock_event_state_notifier.dart';

/// Firebaseユーザー判定のUIチェック
void main() {
  testWidgets('ログイン済みならNavigationを表示', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) {
          return Stream.value(testUser);
        }),
        // Navigation/CalenderPageで使用するproviderをモックに置き換え
        eventStateNotifierProvider.overrideWith(() {
          return MockEventStateNotifier();
        }),
      ],
      child: const MaterialApp(home: App()),
    ));

    // ビルドが終わるまで呼び続ける
    await tester.pumpAndSettle();

    // Navigation が表示されているか
    expect(find.byType(Navigation), findsOneWidget);
    expect(find.byType(LogIn), findsNothing);
  });

  testWidgets('未ログインならLogInを表示', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(null)),
        ],
        child: const MaterialApp(home: App()),
      ),
    );

    // ビルドが終わるまで呼び続ける
    await tester.pumpAndSettle();

    expect(find.byType(LogIn), findsOneWidget);
    expect(find.byType(Navigation), findsNothing);
  });

  testWidgets('ローディング状態ならインジケータを表示', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        // ローディング状態を模擬
        authStateProvider.overrideWith((ref) => Stream<UserEntity?>.periodic(
            const Duration(seconds: 1), (count) => null).take(1)),
      ],
      child: const MaterialApp(home: App()),
    ));
    // emit前のローディング状態で確認
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(); // pending Timer を消化して安全にテスト終了
  });

  testWidgets('エラーならエラーテキストを表示', (tester) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [
        authStateProvider.overrideWith(
          (ref) => Stream.error('error'),
        ),
      ], child: const MaterialApp(home: App())),
    );

    await tester.pump();

    expect(
        find.text('Error occurred while checking user status'), findsOneWidget);
  });
}

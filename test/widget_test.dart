import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workout_manager/core/logger.dart';
import 'package:flutter_workout_manager/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 0がないことを確認する
    expect(find.text('0'), findsNothing);
    // アプリ名が表示されていることを確認
    expect(find.text('Home Fitness Manager'), findsOneWidget);
  });

  tearDownAll(() {
    logger.i('テスト終了');
  });
}

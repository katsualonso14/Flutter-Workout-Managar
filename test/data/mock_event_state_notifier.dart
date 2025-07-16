import 'package:flutter_workout_manager/domain/entities/my_event_info_entity.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';

/// EventStateNotifierを継承したモック
class MockEventStateNotifier extends EventStateNotifier {
  @override
  Future<Map<DateTime, List<MyEventInfoEntity>>> getEventFromIds(
      String uid) async {
    // テスト用の仮の値を返す
    return {
      DateTime(2023, 10, 1): [
        MyEventInfoEntity(
          eventId: 'test_event_id_1',
          event: 'Test Event 1',
        ),
      ],
      DateTime(2023, 10, 2): [
        MyEventInfoEntity(
          eventId: 'test_event_id_2',
          event: 'Test Event 2',
        ),
      ],
    };
  }
}

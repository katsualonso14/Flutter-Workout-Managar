import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:flutter_workout_manager/domain/entities/my_event_info_entity.dart';

abstract class EventRepository {
  Future<Map<DateTime, List<MyEventInfoEntity>>> getEventFromIds(String id);
  Future<void> addEvent(EventEntity newEvent);
  Future<void> deleteEvent(String uid, String eventId);
  Future<int> checkWeeklyEventCount(String uid, String duration);
}

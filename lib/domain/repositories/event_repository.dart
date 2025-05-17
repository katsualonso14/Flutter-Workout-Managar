import 'package:flutter_workout_manager/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<String>> getMyEventIds(String uid);
  Future<Map<DateTime, List<String>>?> getEventFromIds(String id);
  Future<void> addEvent(String event, EventEntity newEvent);
  Future<void> deleteEvent(String uid, String eventName);
  Future<int> checkWeeklyEventCount(String uid, String duration);
}
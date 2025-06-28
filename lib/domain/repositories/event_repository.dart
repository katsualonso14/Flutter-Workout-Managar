import 'package:flutter_workout_manager/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<String>> getMyEventIds(String uid);
  Future<Map<DateTime, List<Map<String, String>>>?> getEventFromIds(String id);
  Future<void> addEvent(EventEntity newEvent);
  Future<void> deleteEvent(String uid, String eventId);
  Future<int> checkWeeklyEventCount(String uid, String duration);
}
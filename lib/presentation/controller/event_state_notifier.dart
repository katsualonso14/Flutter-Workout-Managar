import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:flutter_workout_manager/domain/entities/my_event_info_entity.dart';
import 'package:flutter_workout_manager/domain/providers/add_event_usecase_provider.dart';
import 'package:flutter_workout_manager/domain/providers/check_weekly_event_count_usecase_provider.dart';
import 'package:flutter_workout_manager/domain/providers/delete_event_usecase_provider.dart';
import 'package:flutter_workout_manager/domain/providers/get_event_from_ids_usecase_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/add_event_usecase.dart';
import 'package:flutter_workout_manager/domain/usecases/check_weekly_event_count_usecase.dart';
import 'package:flutter_workout_manager/domain/usecases/delete_event_usecase.dart';
import 'package:flutter_workout_manager/domain/usecases/get_event_from_ids_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_state_notifier.g.dart';

@riverpod
class EventStateNotifier extends _$EventStateNotifier {
  late final GetEventFromIdsUseCase _getEventFromIds;
  late final AddEventUseCase _addEvent;
  late final DeleteEventUseCase _deleteEvent;
  late final CheckWeeklyEventCountUseCase _checkCount;

  @override
  EventEntity build() {
    _getEventFromIds = ref.read(getEventFromIdsUseCaseProvider);
    _addEvent = ref.read(addEventUseCaseProvider);
    _deleteEvent = ref.read(deleteEventUseCaseProvider);
    _checkCount = ref.read(checkWeeklyEventCountUseCaseProvider);

    return EventEntity(event: '', date: DateTime.now(), userid: '');
  }

  Future<Map<DateTime, List<MyEventInfoEntity>>> getEventFromIds(String uid) =>
      _getEventFromIds(uid);
  Future<void> addEvent(EventEntity newEvent) => _addEvent(newEvent);
  Future<void> deleteEvent(String uid, String eventId) =>
      _deleteEvent(uid, eventId);
  Future<int> checkWeeklyEventCount(String uid, String duration) =>
      _checkCount(uid, duration);
}

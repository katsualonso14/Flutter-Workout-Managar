import 'package:flutter_workout_manager/domain/entities/my_event_info_entity.dart';
import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class GetEventFromIdsUseCase {
  final EventRepository repository;

  GetEventFromIdsUseCase(this.repository);

  Future<Map<DateTime, List<MyEventInfoEntity>>>  call(String id) => repository.getEventFromIds(id);
}
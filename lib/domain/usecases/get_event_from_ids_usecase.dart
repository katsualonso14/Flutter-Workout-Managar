import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class GetEventFromIdsUseCase {
  final EventRepository repository;

  GetEventFromIdsUseCase(this.repository);

  Future<Map<DateTime, List<Map<String, String>>>?>  call(String id) => repository.getEventFromIds(id);
}
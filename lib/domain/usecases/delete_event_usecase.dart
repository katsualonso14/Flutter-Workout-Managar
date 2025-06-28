import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class DeleteEventUseCase {
  final EventRepository repository;

  DeleteEventUseCase(this.repository);

  Future<void> call(String uid, String eventId) => repository.deleteEvent(uid, eventId);
}
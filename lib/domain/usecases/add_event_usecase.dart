import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class AddEventUseCase {
  final EventRepository repository;

  AddEventUseCase(this.repository);

  Future<void> call(EventEntity newEvent) => repository.addEvent(newEvent);
}
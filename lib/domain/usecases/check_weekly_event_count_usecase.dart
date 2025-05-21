import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class CheckWeeklyEventCountUseCase {
  final EventRepository repository;

  CheckWeeklyEventCountUseCase(this.repository);

  Future<int> call(String uid, String duration) => repository.checkWeeklyEventCount(uid, duration);
}
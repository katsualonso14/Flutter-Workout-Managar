import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class GetMyEventIdsUseCase {
  final EventRepository repository;
  GetMyEventIdsUseCase(this.repository);

  Future<List<String>> call(String uid) => repository.getMyEventIds(uid);
}
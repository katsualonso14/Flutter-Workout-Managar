
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/providers/event_repository_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/get_event_from_ids_usecase.dart';

final getEventFromIdsUseCaseProvider = Provider<GetEventFromIdsUseCase>((ref) {
  final repository = ref.read(eventRepositoryProvider);
  return GetEventFromIdsUseCase(repository);
});
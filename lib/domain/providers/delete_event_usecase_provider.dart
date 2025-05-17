import 'package:flutter_workout_manager/data/providers/event_repository_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/delete_event_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deleteEventUseCaseProvider = Provider<DeleteEventUseCase>((ref) {
  final repository = ref.read(eventRepositoryProvider);
  return DeleteEventUseCase(repository);
});
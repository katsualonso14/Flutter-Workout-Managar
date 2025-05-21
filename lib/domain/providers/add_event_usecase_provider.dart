import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/providers/event_repository_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/add_event_usecase.dart';

final addEventUseCaseProvider = Provider<AddEventUseCase>((ref) {
  final repository = ref.read(eventRepositoryProvider);
  return AddEventUseCase(repository);
});
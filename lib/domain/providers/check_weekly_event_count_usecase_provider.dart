import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/providers/event_repository_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/check_weekly_event_count_usecase.dart';

final checkWeeklyEventCountUseCaseProvider = Provider<CheckWeeklyEventCountUseCase>((ref) {
  final repository = ref.read(eventRepositoryProvider);
  return CheckWeeklyEventCountUseCase(repository);
});
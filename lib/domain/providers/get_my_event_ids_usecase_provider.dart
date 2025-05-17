import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/providers/event_repository_provider.dart';
import 'package:flutter_workout_manager/domain/usecases/get_my_event_ids_usecase.dart';

final getMyEventIdsUseCaseProvider = Provider<GetMyEventIdsUseCase>((ref) {
  final repository = ref.read(eventRepositoryProvider); // RepositoryのProvider
  return GetMyEventIdsUseCase(repository);
});

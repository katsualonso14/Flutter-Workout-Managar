import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout_manager/data/repositories/event_repository_impl.dart';
import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl(FirebaseFirestore.instance);
});
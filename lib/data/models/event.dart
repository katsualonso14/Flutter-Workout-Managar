
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
//TODO: 使い方検討
abstract class Event with _$Event {
  const factory Event({
    required String event,
    required Timestamp eventDay,
    required String userid,
  }) = _Event;
}

extension EventMapper on Event {
  EventEntity toEntity() => EventEntity(
    event: event,
    eventDay: eventDay.toDate(),
    userid: userid,
  );

  static Event fromEntity(EventEntity entity) => Event(
    event: entity.event,
    eventDay: Timestamp.fromDate(entity.eventDay),
    userid: entity.userid,
  );
}
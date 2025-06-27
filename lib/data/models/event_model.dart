
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout_manager/data/models/timestamp_converter.dart';
import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
// firebaseのデータを扱うdata層用の型
// Timestamp型を扱うためのコンバーターを使用
// domain層ではeventEntityに変換
abstract class EventModel with _$EventModel {
  const factory EventModel({
    required String event,
    @TimestampConverter() required Timestamp date,
    required String userid,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  factory EventModel.fromEntity(EventEntity entity) => EventModel(
    event: entity.event,
    date: Timestamp.fromDate(entity.date),
    userid: entity.userid,
  );
}

extension EventMapper on EventModel {
  EventEntity toEntity() => EventEntity(
    event: event,
    date: date.toDate(),
    userid: userid,
  );
}
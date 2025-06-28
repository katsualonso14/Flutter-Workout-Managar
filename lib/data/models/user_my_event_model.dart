import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout_manager/data/models/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_my_event_model.freezed.dart';


/// ユーザのMyEventを扱うためのモデル
//TODO: ここの使い方を模索する
@freezed
class UserMyEventModel with _$UserMyEventModel {
  const factory UserMyEventModel({
    @TimestampConverter() required Timestamp eventDate,
    required String eventId,
  }) = _UserMyEventModel;

}


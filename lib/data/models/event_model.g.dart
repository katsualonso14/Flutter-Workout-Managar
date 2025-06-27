// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      event: json['event'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Object),
      userid: json['userid'] as String,
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'event': instance.event,
      'date': const TimestampConverter().toJson(instance.date),
      'userid': instance.userid,
    };

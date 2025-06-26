import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// FirestoreのTimestampを扱うためのコンバーター
// - FirestoreからのデータをJSONとして扱う際に、Timestamp型を適切に変換するために使用
// - Timestamp形はそのままではJSONに変換できない
class TimestampConverter implements JsonConverter<Timestamp, Object> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Object json) {
    // FirestoreからはTimestampとして来る場合とMapの場合もあるためチェック
    if (json is Timestamp) return json;
    throw Exception('Invalid json for Timestamp');
  }

  @override
  Object toJson(Timestamp timestamp) => timestamp;
}
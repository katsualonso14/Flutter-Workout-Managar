import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/data/models/event_model.dart';
import 'package:flutter_workout_manager/domain/entities/event_entity.dart';
import 'package:flutter_workout_manager/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final FirebaseFirestore firestore;

  EventRepositoryImpl(this.firestore);

  @override
  Future<List<String>> getMyEventIds(String uid) async {
    final myEvents = await firestore.collection('users').doc(uid).collection('myEvents').get();
    return myEvents.docs.map((e) => e.id).toList();
  }

  @override
  // Firebase一致したものを取得　
  Future<Map<DateTime, List<String>>?> getEventFromIds(String id) async {
    Map<DateTime, List<String>> events = {};
    final myEvents = await getMyEventIds(id);

    try {
      final firebaseEvents = FirebaseFirestore.instance.collection(
          'calendar_events');
      final doc = myEvents.map((element) => firebaseEvents.doc(element).get())
          .toList();
      // 非同期処理を待つ
      final snapshot = await Future.wait(doc);

      for (var doc in snapshot) {
        // Firebase操作・バグで整合性が取れない場合があるので、存在チェックを行う
        if (!doc.exists) {
          debugPrint('❌ document not found: ${doc.reference.id}');
          continue; // 存在しないならスキップ
        }

        final data = doc.data();
        if (data == null) continue; // 念のため null check

        //TODO: 旧の自分アカウントの場合、nullエラーになるので対応
        final model = EventModel.fromJson(data).toEntity();
        final eventDay = model.eventDay;
        // イベントの日付をDateTime型に変換
        final date = DateTime(eventDay.year, eventDay.month, eventDay.day);
        // タイムゾーンを考慮してUTCに変換
        final eventDateTime = date.add(date.timeZoneOffset).toUtc();

        // TODO: ここの処理をUseCaseに移動
        // 日付が同じなら同じリストに追加
        if (events.containsKey(eventDateTime)) {
          events[eventDateTime]!.add(model.event);
        } else {
          events[eventDateTime] = [model.event];
        }
      }

      return events;
    } on FirebaseException catch (e) {
      print('自分の投稿取得失敗 $e'); //デバッグ用
      return null;
    }
  }

  @override
// イベントを追加
  Future<void> addEvent(EventEntity newEvent) async {
    final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
    final firebaseUsers = FirebaseFirestore.instance.collection('users');
    final userEvent = firebaseUsers.doc(newEvent.userid).collection('myEvents');

    // イベントの日付をTimeStamp型に変換
    final eventDate = Timestamp.fromDate(newEvent.eventDay);

    // Entity → Model に変換
    final model = EventModel.fromEntity(newEvent);

    // イベント追加
    final result = await firebaseEvents.add(model.toJson());

    //TODO: data層用の型を作成し変換(UserMyEventModelなど)
    userEvent.doc(result.id).set({
      'eventTime': eventDate,
      'event_id': result.id,
    });
  }

  @override
  // イベントを削除
  Future<void> deleteEvent(String uid, String eventName) async {
    final firebaseUsers = FirebaseFirestore.instance.collection('users');
    final userEvent = firebaseUsers.doc(uid).collection('myEvents');
    final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
    // イベント名が一致するものを取得
    final event = await firebaseEvents.where('event', isEqualTo: eventName).get();
    final docs = event.docs.first; // 一致したものの最初のものだけ削除(同じ名前のイベントは削除しない)
    await userEvent.doc(docs.id).delete();
    await firebaseEvents.doc(docs.id).delete();
  }

  @override
  // check weekly event count
  Future<int> checkWeeklyEventCount(String uid, String duration) async {
    var eventDays = [];
    final myEvents = await getMyEventIds(uid);
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final monthAgo = now.subtract(const Duration(days: 30));
    final yearAgo = now.subtract(const Duration(days: 365));

    for(String element in myEvents) {
      final firebaseEvents = FirebaseFirestore.instance.collection(
          'calendar_events');
      final doc = await firebaseEvents.doc(element).get();

      final data = doc.data()!;
      final eventDay = data['date'].toDate();
      final date = DateTime(eventDay.year, eventDay.month, eventDay.day);
      final eventDateTime = date.add(date.timeZoneOffset).toUtc();

      // 今週のものをカウント
      if (duration == 'weekly' && eventDateTime.isAfter(weekAgo) && eventDateTime.isBefore(now)) {
        eventDays.add(eventDateTime);
      } else if (duration == 'monthly' && eventDateTime.isAfter(monthAgo) && eventDateTime.isBefore(now)) {
        eventDays.add(eventDateTime);
      } else if (duration == 'yearly' && eventDateTime.isAfter(yearAgo) && eventDateTime.isBefore(now)) {
        eventDays.add(eventDateTime);
      }
    }
    return eventDays.length;
  }
}
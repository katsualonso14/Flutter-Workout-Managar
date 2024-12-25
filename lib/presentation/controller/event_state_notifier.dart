import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_state_notifier.g.dart';

@riverpod
class EventStateNotifier extends _$EventStateNotifier {
  @override
  Event build() {
    return Event(event: '', eventDay: Timestamp.now(), userid: '');
  }

  // FirebaseのUserコレクションからmyEventsを取得
  Future<List<String>> getMyEvents(String uid) async {
    final myEvents = await FirebaseFirestore.instance.collection('users').doc(uid).collection('myEvents').get();
    final event = myEvents.docs.map((e) => e.id).toList();

    return event;

  }

    // Firebase一致したものを取得　
    Future<Map<DateTime, List<String>>?> getEventFromIds(String id) async {

      Map<DateTime, List<String>> events = {};
      final myEvents = await getMyEvents(id);

      try{
        for(String element in myEvents){
          final firebaseEvents =  FirebaseFirestore.instance.collection('calendar_events');
          final doc = await firebaseEvents.doc(element).get();

          final data = doc.data()!;
          final event = data['event'];
          final eventDay = data['date'].toDate();
          final date = DateTime(eventDay.year, eventDay.month, eventDay.day);
          final eventDateTime = date.add(date.timeZoneOffset).toUtc();

          // 日付が同じなら同じリストに追加
          if(events.containsKey(eventDateTime)){
             events[eventDateTime]!.add(event) ;
          } else {
            events[eventDateTime] = [event];
          }
        }

        return events;
      } on FirebaseException catch(e) {
        print('自分の投稿取得失敗 $e'); //デバッグ用
        return null;
      }
    }

    // イベントを追加
    Future<void> addEvent(String event, Event newEvent, Timestamp eventDate) async {
      final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
      final firebaseUsers = FirebaseFirestore.instance.collection('users');
      final userEvent = firebaseUsers.doc(newEvent.userid).collection('myEvents');

      final result = await firebaseEvents.add({
        'date': eventDate,
        'event': event,
        'userid': newEvent.userid,
      });

      userEvent.doc(result.id).set({
        'eventTime': eventDate,
        'event_id': result.id,
      });
    }

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
}
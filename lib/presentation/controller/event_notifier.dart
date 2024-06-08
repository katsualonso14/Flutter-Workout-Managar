
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/models/event.dart';

class EventNotifier extends StateNotifier<Event> {
  EventNotifier() : super(Event(event: '', eventDay: Timestamp.now(), userid: ''));

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
        Future.forEach(myEvents, (String element) async {
          final firebaseEvents =  FirebaseFirestore.instance.collection('calendar_events');
          final doc = await firebaseEvents.doc(element).get();

          final data = doc.data()!;
          final event = data['event'];
          final eventDay = data['date'].toDate();

          // 日付が同じなら同じリストに追加
          if(events.containsKey(DateTime(eventDay.year, eventDay.month, eventDay.day))){
            events[DateTime(eventDay.year, eventDay.month, eventDay.day)]!.add(event);
            return events;
          }
          events[DateTime(eventDay.year, eventDay.month, eventDay.day)] = [event];
        });
        return events;
      } on FirebaseException catch(e) {
        print('自分の投稿取得失敗 $e'); //デバッグ用
        return null;
      }
    }

}
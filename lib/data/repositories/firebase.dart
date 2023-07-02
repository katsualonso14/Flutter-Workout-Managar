
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout_manager/data/models/event.dart';


class FireStore {
  static final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
// Firebaseにイベントを追加
  static addEvent(event) async {
    await firebaseEvents.doc().set({
      'date': Timestamp.fromDate(DateTime.now()),
      'event': event,
      'userid': firebaseEvents.id,
    });
  }

  // TODO idを取得してidで分岐させる
  // ユーザー情報取得
  // static Future<List<String>?> getUserId() async {
  //   try {
  //     final snapshot = await firebaseEvents.get();
  //     List<String> userIds = [];
  //     snapshot.docs.forEach((user) {
  //       userIds.add(user.id);
  //     });
  //     print(userIds);
  //     return userIds;
  //   } catch(e) {
  //     print('取得失敗 ---$e');
  //     return null;
  //   }
  // }

  //イベント取得 //TODO 使ってないが簡単なため今後使うか要検討
  // static Future<List> getEvent() async {
  //   final List<String>? userIds = await getUserId();
  //   var eventList = [];
  //   try {
  //     // firebaseの日付データ取得
  //     await Future.forEach(userIds!, (String id) async {
  //       var doc = await firebaseEvents.doc(id).get();
  //       var data = doc.data();
  //       Event events = Event(
  //         event: data!['event'],
  //         eventDay: data['date']
  //       );
  //       eventList.add(events);
  //     });
  //     return eventList;
  //   } catch(e) {
  //     print('error: $e');
  //   }
  //   return [];
  // }

  // １ヶ月のデータ取得
  static loadFirebaseData(focusedDay) async {
    final lastDay = DateTime(focusedDay.year, focusedDay.month + 1, 0); //月の最後
     Map<DateTime, List<Event>> events = {};

     // TODO withConverterのりかい
    // ここの値が取れていない
    // withConverterがうまくいかない
    final snap = await firebaseEvents
        .withConverter(
        fromFirestore: (event, _) => Event.fromFirestore(event),
        toFirestore: (Event event, _) => event.toFirestore()
    ).get();

    for (var doc in snap.docs) {
      final event = doc.data();
      final _eventDay = event.eventDay.toDate();
      final day = DateTime.utc(_eventDay.year, _eventDay.month, _eventDay.day);

      if (events[day] == null) {
        events[day] = [];
      }

      events[day]!.add(event);
    }
    print('event: $events');
    return events;
  }

}



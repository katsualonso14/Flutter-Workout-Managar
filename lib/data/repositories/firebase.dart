
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/data/models/user.dart';
import 'package:flutter_workout_manager/presentation/pages/calendar_page.dart';


class FireStore {
  static final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
  static final firebaseUsers = FirebaseFirestore.instance.collection('users');

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
// Firebaseにイベントを追加
  static addEvent(event) async {
    await firebaseEvents.doc().set({
      'date': Timestamp.fromDate(DateTime.now()),
      'event': event,
      'userid': firebaseEvents.id,
    });
  }

  // TODO idを取得してidで分岐させる
//  ユーザー情報取得
  static Future<dynamic> getUserId(String uid) async {
    try {
      final snapshot = await firebaseUsers.doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var myAccount = Users(
          uid: uid,
          email: data['email']
      );
      CalendarPage.myAccount = myAccount;
      // TODO ユーザーの状態をもつ
      return true;
    } on FirebaseException catch(e) {
      print('ユーザ取得失敗: $e'); //デバッグ用
      return false;
    }
  }

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

  // FireStoreデータ取得
  static loadFirebaseData(focusedDay) async {
     Map<DateTime, List<Event>> events = {};

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
    return events;
  }

  static Future<dynamic> signIn( {required String email, required String password}) async {
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password,);
      currentFirebaseUser = _result.user;
      print('authサインイン完了'); //デバッグ用
      return _result;
    } on FirebaseException catch(e) {
      print('auth登録エラー： $e'); //デバッグ用
      return '登録エラーしました';
    }
  }

}



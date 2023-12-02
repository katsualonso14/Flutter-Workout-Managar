
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
  static addEvent(event, Event newEvent) async {
    // ログインしているユーザIDと一致したmyEvents
    final _userEvent = firebaseUsers.doc(newEvent.userid).collection('myEvents');
    // イベントを追加
    var result = await firebaseEvents.add({
      'date': Timestamp.fromDate(DateTime.now()),
      'event': event,
      'userid': newEvent.userid,
    });

    //usersコレクションのmyEventsに追加
    _userEvent.doc(result.id).set({
      'eventTime': Timestamp.fromDate(DateTime.now()),
      'event_id': result.id,
    });
  }

//  ユーザー情報取得
  static Future<dynamic> getUserId(String uid) async {
    try {
      final snapshot = await firebaseUsers.doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var myAccount = Users(
          uid: uid,
          email: data['email'],
      );
      // CalendarPage.myAccount = myAccount;

      return true;
    } on FirebaseException catch(e) {
      print('ユーザ取得失敗: $e'); //デバッグ用
      return false;
    }
  }


  // MyEventの中からイベントを見つける
  static Future<Map<DateTime, List<Event>>?> getEventFromIds(List<String> ids) async {
    Map<DateTime, List<Event>> events = {};
      try{
        await Future.forEach(ids, (String id) async {
          var doc = await firebaseEvents.doc(id).get();

          final data = doc.data();
          final _eventDay = data!['date'].toDate();
          final day = DateTime.utc(_eventDay.year, _eventDay.month, _eventDay.day);

          var event = Event(
                  eventDay: data['date'],
                  event: data['event'],
                  userid: data['userid'],
                );

          if(events[day] == null) {
            events[day] = [];
          }
          events[day]!.add(event);

        });
        return events;

      } on FirebaseException catch(e) {
        print('自分の投稿取得失敗 $e'); //デバッグ用
        return null;
      }
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



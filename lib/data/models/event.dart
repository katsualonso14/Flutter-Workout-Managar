
import 'package:cloud_firestore/cloud_firestore.dart';
//イベントクラス
class Event {
  String event;
  Timestamp eventDay;
  String userid;

  Event({required this.event, required this.eventDay, required this.userid});
}



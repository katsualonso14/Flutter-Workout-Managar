
import 'package:cloud_firestore/cloud_firestore.dart';
//イベントクラス
class Event {
  final String event;
  Timestamp eventDay;

  Event({this.event, this.eventDay});
}

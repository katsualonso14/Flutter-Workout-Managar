
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//イベントクラス
// class Event {
//   String event;
//   Timestamp eventDay;
//   String userid;
//
//   Event({required this.event, required this.eventDay, required this.userid});
// }

//TODO: domain層に引き継ぐ

class Event {
  final String event;
  final Timestamp eventDay;
  final String userid;

  Event({required this.event, required this.eventDay, required this.userid});

  factory Event.
  fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {

    final data = snapshot.data()!;

    return Event(
      event: data['event'],
      eventDay: data['date'],
      userid: data['userid'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": eventDay,
      "event": event,
      "userid": userid,
    };
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
//イベントクラス
class Event {
  final String event;
    Timestamp eventDay;

  Event({required this.event, required this.eventDay});

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      event: data['event'],
      eventDay: data['date'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": eventDay,
      "event": event
    };
  }

}



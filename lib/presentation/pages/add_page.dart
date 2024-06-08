//記録追加ページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/presentation/pages/calendar_page.dart';

import '../controller/firebase.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
  final today = Timestamp.fromDate(DateTime.now());
  var event = '';
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _editController,
                onChanged: (value) {
                  event = value;
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Event newEvent = Event(
              //       event: event,
              //       eventDay: today,
              //       userid: 'test',
              //     );
              //     FireStore.addEvent(event, newEvent); //イベント追加処理
              //     _editController.clear();
              //   },
              //   child: Text('イベント登録'),
              // ),
            ],
          )
        ),
    );
  }
}

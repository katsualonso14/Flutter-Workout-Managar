//記録追加ページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/firebase.dart';

class AddPage extends StatelessWidget {
  AddPage({Key key}) : super(key: key);

  final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
  final today = DateTime.now();
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
              ElevatedButton(
                onPressed: () {
                  FireStore.addEvent(event); //イベント追加処理
                  _editController.clear();
                },
                child: Text('イベント登録'),
              ),
            ],
          )
        ),
    );
  }
}

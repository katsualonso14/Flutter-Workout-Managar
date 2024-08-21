//記録追加ページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddPage extends HookConsumerWidget {
  const AddPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = Timestamp.fromDate(DateTime.now());
    var event = '';
    final editController = TextEditingController();

    return  Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: editController,
                onChanged: (value) {
                  event = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  Event newEvent = Event(
                    event: event,
                    eventDay: today,
                    userid: uid,
                  );
                  await ref.read(eventStateNotifierProvider.notifier).addEvent(event, newEvent);
                  editController.clear();
                  // trueを渡しデータ更新実施

                  Navigator.of(context).pop(true);
                },

                child: const Text('イベント登録'),
              ),
            ],
          )
        ),
    );
  }
}

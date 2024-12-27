//記録追加ページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/data/models/eventTiles.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
import 'package:flutter_workout_manager/presentation/widgets/my_ad_banner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddPage extends HookConsumerWidget {
  const AddPage({Key? key, required this.uid, required this.selectedDay}) : super(key: key);
  final String uid;
  final Timestamp selectedDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var event = '';
    final editController = TextEditingController();
    var pickerMenu = useState(eventTitles.first);

    return  Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              const Text('Choose Exercise'),
              const SizedBox(height: 5),
              CupertinoPicker(
                itemExtent: 30,
                onSelectedItemChanged: (int index) {
                  pickerMenu.value = eventTitles[index];
                },
                children: List.generate(eventTitles.length, (index) => Text(eventTitles[index])),
              ),
              const SizedBox(height: 10),
              pickerMenu.value == 'Other (Please Specify)' ? TextField(
                controller: editController,
                onChanged: (value) {
                    event = pickerMenu.value == 'Other (Please Specify)' ? value : pickerMenu.value;
                },
              ) : const SizedBox.shrink(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Event newEvent = Event(
                    event: pickerMenu.value == 'Other (Please Specify)' ? event : pickerMenu.value,
                    eventDay: selectedDay,
                    userid: uid,
                  );
                  await ref.read(eventStateNotifierProvider.notifier).addEvent(
                       pickerMenu.value == 'Other (Please Specify)' ? event : pickerMenu.value,
                       newEvent,
                      selectedDay
                  );
                  editController.clear();
                  // trueを渡しデータ更新実施
                  Navigator.of(context).pop(true);
                },
                child: const Text('Register Event'),
              ),
              const SizedBox(height: 70),
              const MyAdBanner(),
            ],
          )
        ),
    );
  }
}

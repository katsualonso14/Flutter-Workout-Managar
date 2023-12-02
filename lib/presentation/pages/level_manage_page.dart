// 筋トレレベル管理ページ

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/presentation/controller/firebase.dart';
import 'package:flutter_workout_manager/presentation/pages/add_page.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class LevelManagePage extends HookConsumerWidget {
  LevelManagePage({Key? key, required this.data}) : super(key: key);

  final User data;
  final _calendarFormat = [
    CalendarFormat.month,
    CalendarFormat.twoWeeks,
    CalendarFormat.week
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用useState
    final _focusedDay = useState(DateTime.now()); // 初期値が今日日付のuseState

    //TODO: ユーザー情報を取得して、そのユーザーのイベントを取得する
    final user = ref.read(userStateProvider);
    final test = ref.read(eventStateProvider.notifier).getEventFromIds(data.uid);


    // 最終的に欲しい形は、<DateTime, List<Event>>のMap型

    //　イベントカウント関数
    int eventCount(value) {
      var eventCount = value[_focusedDay.value];
      if (eventCount == null) {
        return 0;
      } else {
        return eventCount.length;
      }
    }

    return Column(
      children: [
        ElevatedButton(onPressed: () async {
          print('test: ${await test}');

        }, child: Text('test')),
        TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            onPageChanged: (focusedDay) async {
              // print(snapshot.data!);
              _focusedDay.value = focusedDay;
            },
            focusedDay: _focusedDay.value,
            eventLoader: (date) {
              return [];
              // return event[][date] ?? [];
            },
            calendarFormat: _calendarFormat[formatIndex.value],
            // デフォルトを月表示に設定
            onFormatChanged: (format) {
              // useStateの値がタップ時フォーマットでなければカレンダーのindexに今のフォーマットインデックスを代入
              if (formatIndex.value != format.index) {
                formatIndex.value = format.index;
              }
            },
            // 選択日のアニメーション
            selectedDayPredicate: (day) {
              return isSameDay(_focusedDay.value, day);
            },
            // 日付が選択されたときの処理
            onDaySelected: (selectedDay, focusedDay) {
              _focusedDay.value = focusedDay;
            })
      ],
    );
  }
}

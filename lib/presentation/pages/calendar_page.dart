//カレンダーページ
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/data/repositories/firebase.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends HookWidget {
   CalendarPage({Key? key}) : super(key: key);

  final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week]; // カレンダーフォーマット配列
  @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用useState
    final _focusedDay = useState(DateTime.now()); // 初期値が今日日付のuseState
    final List<String> id = ['CBJ1nH4CVXn16oYoGvND','OEvMNwh48QUlZuvV0ZMz'];
    final ev = useState({});

    //　イベントカウント関数
    int eventCount() {
      final eventCount = ev.value[_focusedDay.value];
      if(eventCount == null) {
        return 0;
      } else {
        return eventCount.length;
      }
    }
    Future getEvent() async {
      final eventList = await FireStore.loadFirebaseData(_focusedDay.value);
      ev.value = eventList;
    }

    useEffect((){
      getEvent();
    },const []);

    return Scaffold(
      // カレンダーUI実装
      body: Column(
                  children: [
                    TableCalendar(
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2024, 12, 31),
                        onPageChanged: (focusedDay)  async {
                          final eventList =  await FireStore.loadFirebaseData(focusedDay);
                          ev.value = eventList;
                          _focusedDay.value = focusedDay;
                        },
                        focusedDay: _focusedDay.value,
                        eventLoader: (date) {
                          print(date);
                          return ev.value[date] ?? [];
                        },
                        calendarFormat: _calendarFormat[formatIndex.value], // デフォルトを月表示に設定
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
                        }
                    ),
                    // タップした時表示するリスト
                    Expanded(
                      child: ListView.builder(
                        itemCount: eventCount(),
                        // itemCount: 1,
                        itemBuilder: (context, index) {
                          final event = ev.value[_focusedDay.value][index];
                          return Card(
                            child: ListTile(
                                title: Text(event.event.toString())
                                ),
                              );
                            },
                          )
                    ),
                  ],
                ),
            );
  }
}

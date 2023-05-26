//カレンダーページ
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/data/repositories/firebase.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends HookWidget {
   CalendarPage({Key key}) : super(key: key);

  final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week]; // カレンダーフォーマット配列

  //Map形式で保持　keyが日付　値が文字列 //TODO サンプルmapではなくFirebaseの値でMAP型を作る
  final sampleMap = {
    DateTime.utc(2023, 4,20): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 5,5): ['thirdEvent', 'fourthEvent'],
  };

  @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用useState
    final _focusedDay = useState(DateTime.now()); // 初期値が今日日付のuseState
    final _selectedEvents = useState([]);
    final List<String> id = ['CBJ1nH4CVXn16oYoGvND','OEvMNwh48QUlZuvV0ZMz'];
    final ev = useState({});

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
                          return ev.value[date];
                        },
                        calendarFormat: _calendarFormat[formatIndex.value], // デフォルトを月表示に設定
                        onFormatChanged: (format) {
                          // useStateの値がタップされた際のフォーマット(format)のindexでなければカレンダーのindexに今のフォーマットインデックスを代入
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

                            // _selectedEvents.value = sampleMap[selectedDay] ?? [];
                            // final event = snapshot.data[0];// TODO ここの修正が必要
                            // final eventTime = event.eventDay.toDate();
                            // final eventDay = DateTime.utc(eventTime.year, eventTime.month, eventTime.day); // 日付のみ取得(DateTime.utc())
                            //TODO 日付起因でイベント表示 (ハウスアプリはindex番目で日付を表示していた)（今回は日付があっているもの）

                            //選択日と保存されている日が同じなら値を代入


                            // _selectedEvents.value = sampleMap[eventDay];
                        }
                    ),
                    // タップした時表示するリスト
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedEvents.value.length,
                        itemBuilder: (context, index) {
                          // final event = snapshot.data[index];
                          // var eventContent = event.event;
                          return Card(
                            child: ListTile(
                                title: Text('eventContent')
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

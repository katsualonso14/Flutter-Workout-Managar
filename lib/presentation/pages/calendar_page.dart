//カレンダーページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/data/models/user.dart';
import 'package:flutter_workout_manager/data/repositories/firebase.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends HookWidget {
   CalendarPage({Key? key}) : super(key: key);
   // カレンダーフォーマット配列
   final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week];
   static Users? myAccount;
   @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用useState
    final _focusedDay = useState(DateTime.now()); // 初期値が今日日付のuseState
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
    // Future<Map>  getEvent() async {
    //   final eventList = await FireStore.loadFirebaseData(_focusedDay.value);
    //   ev.value = eventList;
    //   return ev.value;
    // }
    //


    return Scaffold(
      // カレンダーUI実装
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStore.firebaseUsers.doc(myAccount?.uid).collection('myEvents').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return  Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                  child: CircularProgressIndicator()),
            );
          }
          if(snapshot.hasData) {
            // 自分のカレンダーイベントのIDを取得
            List<String> myEventIds = List.generate(snapshot.data!.docs.length, (index) {
              return snapshot.data!.docs[index].id;
            });
            return FutureBuilder<Map<DateTime, List<Event>>?>(
              // calendar_eventsから自分のイベントを取得
                future: FireStore.getEventFromIds(myEventIds),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Column(
                      children: [
                        TableCalendar(
                            firstDay: DateTime.utc(2023, 1, 1),
                            lastDay: DateTime.utc(2024, 12, 31),
                            onPageChanged: (focusedDay) async {
                              ev.value = snapshot.data!;
                              _focusedDay.value = focusedDay;
                            },
                            focusedDay: _focusedDay.value,
                            eventLoader: (date)  {
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
                                      title: Text(event)
                                  ),
                                );
                              },
                            )
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
              );
          } else {
            return Container();
          }
        }
      ),
    );
  }
}

//カレンダーページ
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends HookWidget {
   CalendarPage({Key key}) : super(key: key);

  final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week]; // カレンダーフォーマット配列

  //Map形式で保持　keyが日付　値が文字列
  final sampleMap = {
    DateTime.utc(2023, 5,20): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 5,5): ['thirdEvent', 'fourthEvent'],
  };

   final events = [];
  @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用useState
    final _focuseDay = useState(DateTime.now()); // 初期値が今日日付のuseState
    final _selectedEvents = useState([]);

    return Scaffold(
      // カレンダーUI実装
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _focuseDay.value,
                eventLoader: (date) { // イベントドット処理
                  return sampleMap[date] ?? [];
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
                  return isSameDay(_focuseDay.value, day);
                },
                // 日付が選択されたときの処理
                onDaySelected: (selectedDay, focusedDay) {
                    _focuseDay.value = focusedDay;
                    _selectedEvents.value = sampleMap[selectedDay] ?? [];
                }
            ),
          ),
          // タップした時表示するリスト
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.value.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents.value[index];
                return Card(
                  child: ListTile(
                    title: Text(event),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//カレンダーページ
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends HookWidget {
   CalenderPage({Key? key}) : super(key: key);

  DateTime _focusedDay = DateTime.now(); // 現在日
  DateTime? _selectedDay; // 選択している日付
  List<String> _selectedEvents = [];
  final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week]; // カレンダーフォーマット配列

  //Map形式で保持　keyが日付　値が文字列
  final sampleMap = {
    DateTime.utc(2023, 3,20): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 3,5): ['thirdEvent', 'fourthEvent'],
  };

  final sampleEvents = {
    DateTime.utc(2023, 3,20): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 3,5): ['thirdEvent', 'fourthEvent']
  };
  @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0);
    return Scaffold(
      // カレンダーUI実装
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _focusedDay,
                eventLoader: (date) { // イベントドット処理
                  return sampleMap[date] ?? [];
                },
                calendarFormat: _calendarFormat[formatIndex.value], // デフォを月表示に設定
                onFormatChanged: (format) {  // 「月」「週」変更
                  if (formatIndex.value != format) { // タップされた際に
                    formatIndex.value = format.index;
                  }
                },
                // 選択日のアニメーション
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                // 日付が選択されたときの処理
                onDaySelected: (selectedDay, focusedDay) {
                  // setState(() {
                  //   _selectedDay = selectedDay;
                  //   _focusedDay = focusedDay;
                  //   _selectedEvents = sampleEvents[selectedDay] ?? [];
                  // });
                }
            ),
          ),
          // タップした時表示するリスト
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
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

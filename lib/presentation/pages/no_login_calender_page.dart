
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/presentation/widgets/no_login_alert_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class NoLoginCalendarPage extends HookWidget {
  const NoLoginCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatIndex = useState(0);
    final _focusedDay = useState(DateTime.now());
    final calendarFormat = [
      CalendarFormat.month,
      CalendarFormat.twoWeeks,
      CalendarFormat.week
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー機能の確認'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            eventLoader: (date) {
              return [];
            },
            calendarFormat: calendarFormat[formatIndex.value],
            onFormatChanged: (format) {
                if (formatIndex.value != format.index) {
                  formatIndex.value = format.index;
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_focusedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _focusedDay.value = focusedDay;
              }),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return const Card(
                  child: ListTile(
                    title: Text('こちらにはイベントが表示されます', style: TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return const NoLoginAlertDialog();
                }
            );
          },
          elevation: 0.0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



// 筋トレレベル管理ページ

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
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
    final eventStateNotifier = ref.watch(eventStateNotifierProvider.notifier);
    final eventData = useState<Map<DateTime, List<String>>?>(null);

    useEffect(() {
      // 初回データ取得
      eventStateNotifier.getEventFromIds(data.uid).then((value) {
        eventData.value = value;
      });
      return null;
    }, []);

    //　イベントカウント関数
    int eventCount(Map<DateTime, List<String>> eventData) {
      var eventCount = eventData[_focusedDay.value];
      if (eventCount == null) {
        return 0;
      } else {
        return eventCount.length;
      }
    }

    return eventData.value == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              TableCalendar(
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2024, 12, 31),
                  focusedDay: _focusedDay.value,
                  eventLoader: (date) {
                    return eventData.value![date] ?? [];
                  },
                  calendarFormat: _calendarFormat[formatIndex.value],
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
                    print(eventData.value![_focusedDay.value]);
                  }),
              Expanded(
                child: ListView.builder(
                  itemCount: eventCount(eventData.value!),
                  itemBuilder: (context, index) {
                    final events = eventData.value![_focusedDay.value] ?? [];
                    if (index >= events.length) {
                      return const SizedBox.shrink();
                    }
                    return Card(
                      child: ListTile(
                        title: Text(events[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

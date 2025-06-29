// 筋トレレベル管理ページ
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/domain/entities/my_event_info_entity.dart';
import 'package:flutter_workout_manager/presentation/controller/auth_providers.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
import 'package:flutter_workout_manager/presentation/pages/add_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends HookConsumerWidget {
  CalenderPage({Key? key}) : super(key: key);

  final _calendarFormat = [
    CalendarFormat.month,
    CalendarFormat.twoWeeks,
    CalendarFormat.week
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatIndex = useState(0); // カレンダーフォーマット変更用
    final focusedDayState = useState(DateTime.now()); // 初期値が今日日付のuseState
    final eventStateNotifier = ref.watch(eventStateNotifierProvider.notifier);
    final eventData = useState<Map<DateTime, List<MyEventInfoEntity>>>({});
    final isLoading = useState(true); // ローディング用フラグ

    final data = ref.watch(authStateProvider).value; // FirebaseAuthのインスタンスを取得

    if (data == null) {
      return const Center(child: Text('Please log in.'));
    }

    // データを取得してeventDataを更新する関数
    Future<void> fetchEventData() async {
      isLoading.value = true;
      final getData = await eventStateNotifier.getEventFromIds(data.uid);
      eventData.value = getData;
      isLoading.value = false;
    }

    useEffect(() {
      // 初回データ取得
      fetchEventData();
      return () {};
    },const []);

    //　イベントカウント関数
    int eventCount(Map<DateTime, List<MyEventInfoEntity>> eventData) {
      var eventCount = eventData[focusedDayState.value];
      if (eventCount == null) {
        return 0;
      } else {
        return eventCount.length;
      }
    }

    return isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Column(
              children: [
                TableCalendar(
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: focusedDayState.value,
                    eventLoader: (date) {
                      return eventData.value[date] ?? [];
                    },
                    calendarFormat: _calendarFormat[formatIndex.value],
                    onFormatChanged: (format) {
                      if (formatIndex.value != format.index) {
                        formatIndex.value = format.index;
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(focusedDayState.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      focusedDayState.value = focusedDay;
                    }),
                Expanded(
                  child: ListView.builder(
                    itemCount: eventCount(eventData.value),
                    itemBuilder: (context, index) {
                      final events = eventData.value[focusedDayState.value] ?? [];
                      if (index >= events.length) {
                        return const SizedBox.shrink();
                      }
                      return Dismissible(
                        key: Key(events[index].eventId),
                        onDismissed: (direction) async {
                          await eventStateNotifier.deleteEvent(data.uid, events[index].eventId);
                          await fetchEventData();
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(events[index].event),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddPage(
                              uid: data.uid,
                              selectedDay: focusedDayState.value
                          );
                        }));

                        if (result == true) {
                          await fetchEventData();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

// //カレンダーページ
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_workout_manager/data/models/event.dart';
// import 'package:flutter_workout_manager/data/models/user.dart';
// import 'package:flutter_workout_manager/presentation/controller/firebase.dart';
// import 'package:flutter_workout_manager/presentation/pages/add_page.dart';
// import 'package:flutter_workout_manager/presentation/state/providers.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class CalendarPage extends HookConsumerWidget {
//    CalendarPage({Key? key}) : super(key: key);
//    // カレンダーフォーマット配列
//    final _calendarFormat = [CalendarFormat.month, CalendarFormat.twoWeeks, CalendarFormat.week];
//    //
//
//    @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formatIndex = useState(0); // カレンダーフォーマット変更用useState
//     final _focusedDay = useState(DateTime.now()); // 初期値が今日日付のuseState
//
//     //TODO: ユーザー情報を取得して、そのユーザーのイベントを取得する
//
//     final userState = ref.read(userStateProvider); // ユーザー情報取得
//
//     //　イベントカウント関数
//     int eventCount(value) {
//       var eventCount = value[_focusedDay.value];
//       if(eventCount == null) {
//         return 0;
//       } else {
//         return eventCount.length;
//       }
//     }
//
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Workout Manager'),),
//       // body: FutureBuilder<Map<DateTime, List<Event>>?>(
//       //         // calendar_eventsから自分のイベントを取得
//       //           future: FireStore.getEventFromIds(userIdList),
//       //           builder: (context, snapshot) {
//       //             if(snapshot.hasData) {
//       //               return Column(
//       //                 children: [
//       //                   TableCalendar(
//       //                       firstDay: DateTime.utc(2023, 1, 1),
//       //                       lastDay: DateTime.utc(2024, 12, 31),
//       //                       onPageChanged: (focusedDay) async {
//       //                         // print(snapshot.data!);
//       //                         _focusedDay.value = focusedDay;
//       //                       },
//       //                       focusedDay: _focusedDay.value,
//       //                       eventLoader: (date)  {
//       //                         return snapshot.data![date] ?? [];
//       //                         // return ev.value[date] ?? [];
//       //                       },
//       //                       calendarFormat: _calendarFormat[formatIndex.value], // デフォルトを月表示に設定
//       //                       onFormatChanged: (format) {
//       //                         // useStateの値がタップ時フォーマットでなければカレンダーのindexに今のフォーマットインデックスを代入
//       //                         if (formatIndex.value != format.index) {
//       //                           formatIndex.value = format.index;
//       //                         }
//       //                       },
//       //                       // 選択日のアニメーション
//       //                       selectedDayPredicate: (day) {
//       //                         return isSameDay(_focusedDay.value, day);
//       //                       },
//       //                       // 日付が選択されたときの処理
//       //                       onDaySelected: (selectedDay, focusedDay) {
//       //                         _focusedDay.value = focusedDay;
//       //                       }
//       //                   ),
//       //                   // タップした時表示するリスト
//       //                   Expanded(
//       //                       child: ListView.builder(
//       //                         itemCount: eventCount(snapshot.data),
//       //                         // itemCount: 1,
//       //                         itemBuilder: (context, index) {
//       //                           final event = snapshot.data![_focusedDay.value];
//       //                           return Card(
//       //                             child: ListTile(
//       //                                 title: Text(event![index].event),
//       //                             ),
//       //                           );
//       //                         },
//       //                       )
//       //                   ),
//       //                 ],
//       //               );
//       //             } else {
//       //               print('not data');
//       //               return Container();
//       //             }
//       //           }
//       //         ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           // FireStore.getEvent(id);
//           Navigator.of(context).push(
//               MaterialPageRoute(builder: (context){
//                 return AddPage();
//               })
//           );
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         elevation: 0.0,
//       ),
//     );
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';


// ナビゲーションバー用のプロバイダー　初期値はカレンダーページを設定
final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.calendar);

final calendarFormatProvider = StateProvider<myCalendarFormat>((ref) => myCalendarFormat.month);

// プロバイダー用の文字列リスト
enum ViewType { calendar, levelManage }

enum myCalendarFormat {
  month(format: CalendarFormat.month),

  twoweeks(format: CalendarFormat.twoWeeks),

  week(format: CalendarFormat.week);

  const myCalendarFormat({required this.format});

  final CalendarFormat format;
}
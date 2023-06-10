import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';


// ナビゲーションバー用のプロバイダー　初期値はカレンダーページを設定
final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.calendar);

// プロバイダー用の文字列リスト
enum ViewType { calendar, levelManage }

// ログイン・新規登録用プロバイダー
final emailProvider = StateProvider((ref) => '');
final passwordProvider = StateProvider((ref) => '');
final infoTextProvider = StateProvider((ref) => '');
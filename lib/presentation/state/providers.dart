import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/models/event.dart';
import 'package:flutter_workout_manager/data/models/user.dart';
import 'package:flutter_workout_manager/presentation/controller/event_notifier.dart';
import 'package:flutter_workout_manager/presentation/controller/user_notifier.dart';


// ナビゲーションバー用のプロバイダー　初期値はカレンダーページを設定
final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.calendar);

// プロバイダー用の文字列リスト
enum ViewType { calendar, levelManage }

// ログイン・新規登録用プロバイダー
final userCheckProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final emailProvider = StateProvider((ref) => '');

final passwordProvider = StateProvider((ref) => '');
final infoTextProvider = StateProvider((ref) => '');


final userStateProvider = StateNotifierProvider<UserNotifier, Users>( (ref) {
  return UserNotifier();
});

// final eventStateProvider = StateNotifierProvider<EventNotifier, Event>( (ref) {
//   return EventNotifier();
// });
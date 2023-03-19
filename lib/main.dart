import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
// ナビゲーションバー用のプロバイダー　初期値はカレンダーページを設定
final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.calendar);
// プロバイダー用の文字列リスト
enum ViewType { calendar, levelManage }

void main() {
  // ProviderScopeで囲むことでriverpodを利用可能にする
  runApp(ProviderScope(child: MyApp()));
}

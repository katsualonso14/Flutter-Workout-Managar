import 'package:flutter_riverpod/flutter_riverpod.dart';

// ログイン画面で必要な情報を保持するプロバイダー
final emailProvider = StateProvider((ref) => '');
final passwordProvider = StateProvider((ref) => '');
final infoTextProvider = StateProvider((ref) => '');

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  // ProviderScopeで囲むことでriverpodを利用可能にする
  runApp(ProviderScope(child: MyApp()));
}

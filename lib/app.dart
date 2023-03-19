
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'main.dart';

import 'presentation/page/calender_page.dart';
import 'presentation/page/level_manage_page.dart';

// ConsumerWidgetでナビゲーションバーの状態管理
class MyApp extends ConsumerWidget {
   MyApp({Key? key}) : super(key: key);

  final _screens = [
    CalenderPage(),
    LevelManagePage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ナビゲーション用のプロバイダーをwatchで取得
    final view = ref.watch(baseTabViewProvider.state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text('Workout Manager')),
          body: _screens[view.state.index], //プロバイダーで選択された番号(index)のページを表示
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, '/add_page');
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            elevation: 0.0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: view.state.index, // //プロバイダーで選択された番号(index)のページを表示
            onTap: (int index) => view.update((state) => ViewType.values[index]), // プロバイダーをアップデートし現在のページを表示
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
              BottomNavigationBarItem(icon: Icon(Icons.signal_cellular_alt), label: 'レベル'),
            ],
          ),
        ),
    );
  }
}

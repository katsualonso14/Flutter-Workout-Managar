
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/repositories/providers.dart';

import 'presentation/page/calender_page.dart';
import 'presentation/page/level_manage_page.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  final _screens = [
    CalenderPage(),
    LevelManagePage()
  ];
  @override
  Widget build(BuildContext context) {
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
          // onTap: (int index) => view.update((state) => ViewType.values[index]), // プロバイダーをアップデートし現在のページを表示
          onTap: (int index){
            // 値は入れれてるが更新でhない
            view.state = ViewType.values[index];
            print('on tap');
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
            BottomNavigationBarItem(icon: Icon(Icons.signal_cellular_alt), label: 'レベル'),
          ],
        ),
      ),
    );
  }
}

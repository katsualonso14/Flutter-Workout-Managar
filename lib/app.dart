
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/pages/add_page.dart';
import 'package:flutter_workout_manager/presentation/pages/calendar_page.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';

import 'presentation/state/providers.dart';


// 機能を増やした際にBottomNavigationBarItemを使用予定
class MainApp extends ConsumerWidget {
   MainApp({Key? key}) : super(key: key);

  final _screens = [
    CalendarPage(),
    AddPage()
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ナビゲーション用のプロバイダーをwatchで取得
    final view = ref.watch(baseTabViewProvider.state);
    return Scaffold(
        appBar: AppBar(
            title: const Text('Workout Manager'),
          leading: ElevatedButton(
              child: Text('戻る'),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return LogIn();
                  })
                );
              },
            ),
        ),
        body: _screens[view.state.index], //プロバイダーで選択された番号(index)のページを表示
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            // FireStore.getEvent(id);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
              return AddPage();
            })
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: view.state.index, // //プロバイダーで選択された番号(index)のページを表示
          onTap: (int index){
            view.state = ViewType.values[index]; //インデック番目のViewTypeをviewに代入
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: '作成'),
          ],
        ),
    );
  }
}

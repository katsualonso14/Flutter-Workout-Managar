
import 'package:flutter/material.dart';
import 'presentation/page/add_page.dart';
import 'presentation/page/calender_page.dart';
import 'presentation/page/level_manage_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Screen(),
      routes: {
        '/add_page':(BuildContext context) => const AddPage(),
      }
    );
  }
}


class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  static const _screens = [
    CalenderPage(),
    LevelManagePage()
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Workout Manager')),
        body: _screens[_selectedIndex],
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
          currentIndex: 0,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.signal_cellular_alt), label: 'レベル'),
          ],
        ),
      );
  }
}

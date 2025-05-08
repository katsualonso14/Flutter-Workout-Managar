import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/domain/entities/view_type.dart';
import 'package:flutter_workout_manager/presentation/controller/navi_provider.dart';
import 'package:flutter_workout_manager/presentation/pages/calender_page.dart';
import 'package:flutter_workout_manager/presentation/pages/count_page.dart';
import 'package:flutter_workout_manager/presentation/widgets/my_ad_banner.dart';

class Navigation extends ConsumerWidget {
  const Navigation({Key? key, required this.data}) : super(key: key);
  final User data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewState = ref.watch(naviProvider.state);
    final pages = [
       CalenderPage(data: data),
       CountPage(data: data),
    ];

    return Scaffold(
      body: pages[viewState.state.index],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAdBanner(),
          BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calender'),
                BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: 'Count'),
              ],
            currentIndex: viewState.state.index,
            onTap: (int index) {
                viewState.state = ViewType.values[index];
            },
          ),
        ],
      ),
    );
  }
}

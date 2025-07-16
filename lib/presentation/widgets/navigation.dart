import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/domain/entities/view_type.dart';
import 'package:flutter_workout_manager/presentation/controller/auth_providers.dart';
import 'package:flutter_workout_manager/presentation/controller/navi_provider.dart';
import 'package:flutter_workout_manager/presentation/pages/calender_page.dart';
import 'package:flutter_workout_manager/presentation/pages/count_page.dart';
import 'package:flutter_workout_manager/presentation/widgets/my_ad_banner.dart';
import 'package:flutter_workout_manager/presentation/widgets/my_app_bar.dart';

class Navigation extends ConsumerWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(naviProvider);
    final data = ref.watch(authStateProvider).value; // FirebaseAuthのインスタンスを取得

    if (data == null) {
      return const Center(child: Text('Please log in.'));
    }

    final pages = [
      CalenderPage(),
      CountPage(data: data),
    ];

    return Scaffold(
      appBar: const MyAppBar(),
      body: pages[viewState.index],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAdBanner(),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_chart), label: 'Count'),
            ],
            currentIndex: viewState.index,
            onTap: (int index) {
              ref.read(naviProvider.notifier).update(
                    (state) => ViewType.values[index],
                  );
            },
          ),
        ],
      ),
    );
  }
}

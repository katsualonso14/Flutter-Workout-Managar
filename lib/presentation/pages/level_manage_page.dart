// 筋トレレベル管理ページ

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';

class LevelManagePage extends ConsumerWidget {
  const LevelManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: ref.watch(userStateProvider).length,
                itemBuilder: (BuildContext context, int index) {
                  final users = ref.read(userStateProvider)[index];
                  return Container(
                    child: ListTile(
                      subtitle: Text('uid: ${users.uid}'),
                      title: Text('Eメール: ${users.email}'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
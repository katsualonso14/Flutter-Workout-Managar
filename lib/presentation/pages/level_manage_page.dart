// 筋トレレベル管理ページ

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';

class LevelManagePage extends ConsumerWidget {
  const LevelManagePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: user.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    subtitle: Text('uid: ${user[index].uid}'),
                    title: Text('Eメール: ${user[index] .email}'),
                  );
                }),
          )
        ],
      ),
    );
  }
}
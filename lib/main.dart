import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/pages/add_page.dart';
import 'package:flutter_workout_manager/presentation/pages/level_manage_page.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: App()));
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCheck = ref.watch(userCheckProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Workout Manager'),),
        body: userCheck.when(
            error: (error, stackTrace) {
              return const Center(child: Text('エラーが発生しました'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            data: (data) {
              if (data != null) {
                return LevelManagePage(data: data);
              } else {
                return LogIn();
              }
            }
        ),
      ),
    );
  }
}

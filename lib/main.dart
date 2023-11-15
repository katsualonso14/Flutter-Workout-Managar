import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/firebase.dart';
import 'package:flutter_workout_manager/presentation/pages/calendar_page.dart';
import 'package:flutter_workout_manager/presentation/pages/level_manage_page.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        // ログイン状態の確認
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }
          if (snapshot.hasData) {
            return LevelManagePage();
          }
          // データがない場合ログインページへ
          return LogIn();
        },
      ),
    );
  }
}

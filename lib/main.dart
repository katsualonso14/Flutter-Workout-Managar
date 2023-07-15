import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/repositories/firebase.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'core/firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // ProviderScopeで囲むことでriverpodを利用可能にする
  // ログインページに移動　TODO ログイン済ユーザーの振り分け
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
   App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            // 状態がwaitngなら
            return SizedBox();
          }
          if (snapshot.hasData) {
            return LogIn();
          }
          return const Text('this is null');
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';
import 'package:flutter_workout_manager/presentation/widgets/navigation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/firebase_options.dart';
import 'presentation/widgets/dialog/delete_check_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: App())));
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCheck = ref.watch(userCheckProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Fitness Manager', style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic)),
          actions: [
            // ログインアウトボタン
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        //英語でcontent: const Text('はいをタップするとログイン画面に戻ります。\n本当にログアウトしますか？'),
                        content: const Text('If you tap "Yes", you will return to the login screen.\nAre you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    }
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const DeleteCheckDialog()
                );
              },
            ),

          ],
        ),

        body: userCheck.when(
            error: (error, stackTrace) {
              return const Center(child: Text('エラーが発生しました'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            data: (data) {
              if (data != null) {
                return Navigation(data: data);
              } else {
                return const LogIn();
              }
            }
        ),
      );
  }
}

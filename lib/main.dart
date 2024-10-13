import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/pages/calender_page.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/firebase_options.dart';

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

    void _performSensitiveAction(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('パスワードの確認が完了し、アカウントを削除いたしました。'),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!.delete();
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }



    void _reauthenticateUser(BuildContext context, String password) async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          String email = user.email!;
          final credential = EmailAuthProvider.credential(email: email, password: password);
          await user.reauthenticateWithCredential(credential);

          _performSensitiveAction(context);

        } catch (e) {
          print('Re-authentication failed: $e');
        }
      }
    }

    Future<void> _showPasswordDialog(BuildContext parentContext) async {
      final TextEditingController passwordController = TextEditingController();
      print('showPasswordDialog');

      await showDialog(
        context: parentContext,  // Pass the context from the parent widget
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('削除するにはパスワードを入力してください'),
            content: TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Enter your password'),
              obscureText: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);  // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final password = passwordController.text;
                  if (password.isNotEmpty) {
                    Navigator.pop(context);  // Close the dialog
                     _reauthenticateUser(parentContext, password);  // Pass the parent context
                  } else {
                    ScaffoldMessenger.of(parentContext).showSnackBar(
                      const SnackBar(content: Text('Please enter a password')),
                    );
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }


    Future<void> deleteUserAccount() async {
      try {
        await FirebaseAuth.instance.currentUser!.delete();
      } on FirebaseAuthException catch (e) {
        print('error: $e');
        await _showPasswordDialog(context);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Manager'),

          actions: [
            // ログインアウトボタン
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('ログアウト'),
                        content: const Text('はいをタップするとログイン画面に戻ります。\n本当にログアウトしますか？'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            child: const Text('はい'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('いいえ'),
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
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('アカウント削除'),
                        content: const Text('はいをタップするとアカウントが削除されます。\n本当に削除しますか？'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await deleteUserAccount();
                              Navigator.pop(context);
                            },
                            child: const Text('はい'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('いいえ'),
                          ),
                        ],
                      );
                    }
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
                return CalenderPage(data: data);
              } else {
                return const LogIn();
              }
            }
        ),
      );
  }
}

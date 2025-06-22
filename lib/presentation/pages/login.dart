import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/sign_in_user_notifier.dart';
import 'package:flutter_workout_manager/presentation/pages/no_login_calender_page.dart';
import 'package:flutter_workout_manager/presentation/controller/login_form_providers.dart';
import 'package:flutter_workout_manager/presentation/widgets/medium_ad_banner.dart';

class LogIn extends ConsumerWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(emailProvider.state);
    final userPassword = ref.watch(passwordProvider.state);
    final signInState = ref.watch(signInUserNotifierProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: const InputDecoration(labelText: "Mail Address"),
                  onChanged: (String value) {
                    userEmail.state = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Password(6 characters or more)"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    userPassword.state = value;
                  },
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // Authのインスタンス生成
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          // createUserWithEmailAndPasswordメソッド でユーザー登録を行う
                          final UserCredential result =
                              await auth.createUserWithEmailAndPassword(
                            email: userEmail.state,
                            password: userPassword.state,
                          );

                          // 登録したユーザー情報
                          final User? user = result.user;
                          if( context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User registered successfully: ${user?.email}')),
                            );
                          }
                        } catch (e) {
                          // 登録に失敗した場合
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'failed to register. Please try again.'
                                      '\nPlease enter a password of 6 characters or more.'
                                      '\nPlease enter a valid email address')),
                            );
                          }
                        }
                      },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // ボタンの背景色
                        foregroundColor: Colors.white, // ボタンの文字色
                    ),
                      child: const Text('Register User Account'),
                  ),

                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // 無効化（多重タップ防止）
                      onPressed: signInState.isLoading ? null : () async {
                              try {
                                await ref
                                    .read(signInUserNotifierProvider.notifier)
                                    .signIn(
                                        userEmail.state, userPassword.state);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Login successful')),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Login failed. Please check your email and password.')),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                      ),
                      child: signInState.isLoading ? const CircularProgressIndicator() : const Text('Login'),
                    )),
                OutlinedButton(
                  child: const Text('Check the calendar function without logging in', style: TextStyle(color: Colors.grey)),

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const NoLoginCalendarPage()));
                    }
                ),
                const SizedBox(height: 30,),
                const MediumAdBanner(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

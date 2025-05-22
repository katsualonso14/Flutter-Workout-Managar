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
    final infoText = ref.watch(infoTextProvider.state);
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
                Container(
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
                          infoText.state = 'The registration has been completed at the following email address.\n${user!.email}';
                        } catch (e) {
                          // 登録に失敗した場合
                          infoText.state = 'failed to register. Please try again.\n*Please enter a password of 6 characters or more.\n*Please enter a valid email address.';
                        }
                      },
                      child: const Text('Register User Account')),
                ),
                SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      // 無効化（多重タップ防止）
                      onPressed: signInState.isLoading ? null : () async {
                              try {
                                await ref
                                    .read(signInUserNotifierProvider.notifier)
                                    .signIn(
                                        userEmail.state, userPassword.state);
                                infoText.state = 'Login successful';
                              } catch (e) {
                                infoText.state =
                                    'Login failed. Please check your email and password.';
                              }
                            },
                      child: signInState.isLoading ? const CircularProgressIndicator() : const Text('Login'),
                    )),
                OutlinedButton(
                  child: const Text('Check the calendar function without logging in', style: TextStyle(color: Colors.grey)),

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const NoLoginCalendarPage()));
                    }
                ),

                Text(infoText.state),
              const MediumAdBanner(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

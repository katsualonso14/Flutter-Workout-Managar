import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/firebase.dart';
import 'package:flutter_workout_manager/presentation/pages/calender_page.dart';
import 'package:flutter_workout_manager/presentation/pages/no_login_calender_page.dart';
import 'package:flutter_workout_manager/presentation/state/providers.dart';
import 'package:flutter_workout_manager/presentation/widgets/my_ad_banner.dart';



class LogIn extends ConsumerWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(emailProvider.state);
    final userPassword = ref.watch(passwordProvider.state);
    final infoText = ref.watch(infoTextProvider.state);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              // テキスト入力のラベルを設定
              decoration: const InputDecoration(labelText: "メールアドレス"),
              onChanged: (String value) {
                userEmail.state = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "パスワード（６文字以上）"),
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
                      infoText.state = '以下のEメールアドレスにて登録が完了いたしました。\n${user!.email}';
                    } catch (e) {
                      // 登録に失敗した場合
                      infoText.state = '登録に失敗いたしました。再度お試しください。\n※パスワードは６文字以上で入力してください。\n※メールアドレスは正しい形式で入力してください。';
                    }
                  },
                  child: const Text('ユーザー登録')),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    var result = await FireStore.signIn(
                        email: userEmail.state, password: userPassword.state);

                    if (result is UserCredential) {
                      var userId = await FireStore.getUserId(result.user!.uid);
                      if (userId == true) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => CalenderPage(data: result.user!)));
                      } else {
                        infoText.state = 'ログインに失敗しました。再度お試しください。\n※パスワードは６文字以上で入力してください。\n※メールアドレスは正しい形式で入力してください。';
                      }
                    } else {
                      infoText.state = 'ログインに失敗しました。再度お試しください。\n※パスワードは６文字以上で入力してください。\n※メールアドレスは正しい形式で入力してください。';
                    }
                  } catch (e) {
                    infoText.state = 'ログインに失敗しました。再度お試しください。\n※パスワードは６文字以上で入力してください。\n※メールアドレスは正しい形式で入力してください。';
                    print(infoText.state);
                  }
                },
              ),
            ),
            OutlinedButton(
              child: const Text('ログインなしでカレンダー機能の確認', style: TextStyle(color: Colors.grey)),

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const NoLoginCalendarPage()));
                }
            ),

            Text(infoText.state),
          const MyAdBanner(),
          ],
        ),
      ),
    );
  }
}

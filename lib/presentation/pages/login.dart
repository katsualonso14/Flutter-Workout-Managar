import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/app.dart';
import 'package:flutter_workout_manager/presentation/controller/firebase.dart';
import 'package:flutter_workout_manager/presentation/pages/level_manage_page.dart';
import '../state/providers.dart';

class LogIn extends ConsumerWidget {
  LogIn({Key? key}) : super(key: key);

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
              decoration: InputDecoration(labelText: "メールアドレス"),
              onChanged: (String value) {
                userEmail.state = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
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
                      infoText.state = '登録OK：${user!.email}';
                    } catch (e) {
                      // 登録に失敗した場合
                      infoText.state = '登録NG：${e.toString()}';
                    }
                  },
                  child: Text('ユーザー登録')),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text('ログイン'),
                onPressed: () async {
                  try {
                    var result = await FireStore.signIn(
                        email: userEmail.state, password: userPassword.state);
                    if (result is UserCredential) {
                      var _result = await FireStore.getUserId(result.user!.uid);
                      if (_result == true) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LevelManagePage(data: result.user!)));
                      } else {
                        infoText.state = 'miss';
                      }
                    }

                    // カレンダーページに遷移 TODO NabBar付きで遷移させる
                    // await Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) {
                    //       return MainApp();
                    //     })
                    // );
                  } catch (e) {
                    infoText.state = 'ログイン失敗: ${e.toString()}';
                    print(infoText.state);
                  }
                },
              ),
            ),
            Text(infoText.state),
          ],
        ),
      ),
    );
  }
}

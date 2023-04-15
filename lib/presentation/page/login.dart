
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO prividerの管理ファイル変更
final emailProvider = StateProvider((ref) => '');
final passwordProvider = StateProvider((ref) => '');
final infoTextProvider = StateProvider((ref) => '');

class LogIn extends ConsumerWidget {
  LogIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newUserEmail = ref.watch(emailProvider.state);
    final newUserPassword = ref.watch(passwordProvider.state);
    final infoText = ref.watch(infoTextProvider.state);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    newUserEmail.state = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    newUserPassword.state = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        // Authのインスタンス生成
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        // createUserWithEmailAndPasswordメソッド でユーザー登録を行う
                        final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                          email: newUserEmail.state,
                          password: newUserPassword.state,
                        );

                        // 登録したユーザー情報
                        final User user = result.user;
                        infoText.state = "登録OK：${user.email}";
                      } catch (e) {
                        // 登録に失敗した場合
                        infoText.state = "登録NG：${e.toString()}";
                      }
                    },
                    child: Text('ユーザー登録')
                ),
                Text(infoText.state),
                Container(
                  child: OutlinedButton(
                    child: Text('ログイン'),
                    onPressed: () async {
                      try {
                        // メール/パスワードでログイン
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.signInWithEmailAndPassword(
                            email: newUserEmail.state,
                            password: newUserPassword.state
                        );
                        print('ログイン成功');
                      } catch (e){
                        print('ログイン失敗');
                        print(e);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

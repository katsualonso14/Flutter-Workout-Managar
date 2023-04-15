
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = StateProvider((ref) => '');
final provider2 = StateProvider((ref) => '');
final provider3 = StateProvider((ref) => '');

class LogIn extends ConsumerWidget {
  LogIn({Key key}) : super(key: key);
// 入力されたメールアドレス
//   String newUserEmail = "";
  // 入力されたパスワード
  // String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  // String infoText = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newUserEmail = ref.watch(provider.state);
    final newUserPassword = ref.watch(provider2.state);
    final infoText = ref.watch(provider3.state);
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
                    // setState(() {
                    //   newUserEmail = value;
                    // });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    newUserPassword.state = value;
                    // setState(() {
                    //   newUserPassword = value;
                    // });
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
                        // setState(() {
                        //   infoText = "登録OK：${user.email}";
                        // });
                      } catch (e) {
                        // 登録に失敗した場合
                        infoText.state = "登録NG：${e.toString()}";
                        // setState(() {
                        //   infoText = "登録NG：${e.toString()}";
                        // });
                      }
                    },


                    child: Text('ユーザー登録')
                ),
                Text(infoText.state)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

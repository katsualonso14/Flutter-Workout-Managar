
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
// 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      newUserEmail = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      newUserPassword = value;
                    });
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
                          email: newUserEmail,
                          password: newUserPassword,
                        );

                        // 登録したユーザー情報
                        final User user = result.user;
                        setState(() {
                          infoText = "登録OK：${user.email}";
                        });
                      } catch (e) {
                        // 登録に失敗した場合
                        setState(() {
                          infoText = "登録NG：${e.toString()}";
                        });
                      }
                    },


                    child: Text('ユーザー登録')
                ),
                Text(infoText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

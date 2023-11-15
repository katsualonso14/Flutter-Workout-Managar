
class Users {
  String uid;
  String email;
  Users({required this.uid, required this.email});

  // factoryを利用する場合、インスタンスは処理内で作成して返却する必要がある
  // 今回は引数(Firestoreの情報)からインスタンスを生成する
  // また引数については、処理内で再設定されないようfinalを追記
  factory Users.toModel(final String uid, final Map<String, dynamic> data) {
    //　ここでインスタンスを生成し返却する
    return Users(
        uid: uid,
        email: data['email']
    );
  }

  // 呼び出されるインスタンスの各フィールド値をMap形式に変換します

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}

// class UserList {
//   List<Users> users = [];
// }

//TODO: domain層に引き継ぐ
//TODO: domain層に引き継ぐ
// Firebaseの元となるユーザークラス
class Users {
  Users({required this.uid, required this.email});
  final String uid;
  final String email;

  // 今回は引数(Firestoreの情報)からインスタンスを生成
  factory Users.
  toModel(String uid, Map<String, dynamic> data) {
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
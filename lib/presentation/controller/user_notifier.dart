
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/models/user.dart';

class UserNotifier extends StateNotifier<Users> {
  UserNotifier() : super(Users(uid: '', email: '')){
    readFirebaseDocument();
  }

  // FirebaseのUserコレクションを読み込む
  Future<void> readFirebaseDocument() async {
    final users = FirebaseFirestore.instance.collection('users');

    final document = await users.withConverter<Users>(
      fromFirestore: (snapshot, _) => Users.toModel(snapshot.id, snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get();
    // ここで取得したデータをstateに設定
    state = document.docs.first.data();
  }

   static Future<dynamic> getUserId(String uid) async {
     final firebaseUsers = FirebaseFirestore.instance.collection('users');
    try {
      final snapshot = await firebaseUsers.doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var myAccount = Users(
          uid: uid,
          email: data['email'],
      );
      // CalendarPage.myAccount = myAccount;

      return true;
    } on FirebaseException catch(e) {
      print('ユーザ取得失敗: $e'); //デバッグ用
      return false;
    }
  }

}

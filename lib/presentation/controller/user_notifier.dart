
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/data/models/user.dart';

class UserNotifier extends StateNotifier<List<Users>> {
  UserNotifier() : super([]){
    // これは初期化処理１度だけ実行されます
    // ここでFirestoreの情報を取得
    _readFirebaseDocument();
  }

  // Firebaseの読み込みを行う関数
  // 対象Documentはusers
  Future<void> _readFirebaseDocument() async {
    // まずはFirebaseを利用するためにinstanceを取得
    // 以降設定することがないのでfinalで定義
    final store = FirebaseFirestore.instance;
    final document = await store
        .collection('users')
        .withConverter<Users>(
      fromFirestore: (snapshot, _) => Users.toModel(snapshot.id, snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get();

    // ここで取得したデータをstateに設定
    state = document.docs.map((doc) => doc.data()).toList();
  }
}

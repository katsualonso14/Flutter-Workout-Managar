

import 'package:firebase_auth/firebase_auth.dart';
// FirebaseAuthのData層とPresentation層の間のインターフェース
abstract class AuthRepository {
  Stream<User?> authStateChanges();
}

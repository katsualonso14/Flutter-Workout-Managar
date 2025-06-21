
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/widgets/dialog/check_password_dialog.dart';


class FireStore {
  static final firebaseEvents = FirebaseFirestore.instance.collection('calendar_events');
  static final firebaseUsers = FirebaseFirestore.instance.collection('users');

  static User? currentFirebaseUser;
  
  // ユーザー削除
  static Future<void> deleteUserAccount(BuildContext parentContext) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print('error: $e');
      await showDialog(
          context: parentContext,  // Pass the context from the parent widget
          builder: (context) => CheckPasswordDialog(parentContext: parentContext)
      );
    } catch (e) {
      print(e);
    }
  }

}



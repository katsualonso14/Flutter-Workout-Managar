import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteSuccessDialog extends StatelessWidget {
  const DeleteSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('パスワードの確認が完了し、アカウントを削除いたしました。'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser!.delete();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
  }
}

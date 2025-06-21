
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/delete_user_provider.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';

class DeleteCheckDialog extends ConsumerWidget {
  const DeleteCheckDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('If you tap "Yes", your account will be deleted.\nAre you sure you want to delete your account?'),
      actions: [
        TextButton(
          //TODO: 削除後の「 Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe.」バグ修正
          onPressed: () async {
            try {
              await ref.read(deleteUserNotifierProvider.notifier).deleteUser();
              if (context.mounted) {
                Navigator.pop(context); // ダイアログ閉じる
              }
              await Future.delayed(const Duration(milliseconds: 300)); // ←猶予を与える
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LogIn()), // ログイン画面へ
                      (route) => false,
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete account')),
                );
              }
            }
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}

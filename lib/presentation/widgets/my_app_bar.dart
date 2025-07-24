import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/widgets/dialog/delete_check_dialog.dart';
import 'package:flutter_workout_manager/presentation/widgets/dialog/logout_alert_dialog.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home Fitness Manager',
          style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic)),
      actions: [
        // ログインアウトボタン
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const LogoutAlertDialog();
                });
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const DeleteCheckDialog());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

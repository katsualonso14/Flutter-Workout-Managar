
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/controller/firebase.dart';

class DeleteCheckDialog extends StatelessWidget {
  const DeleteCheckDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('If you tap "Yes", your account will be deleted.\nAre you sure you want to delete your account?'),
      actions: [
        TextButton(
          onPressed: () async {
            await FireStore.deleteUserAccount(context);
            Navigator.pop(context);
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

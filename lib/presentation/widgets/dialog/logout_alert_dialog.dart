
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('If you tap "Yes", you will return to the login screen.\nAre you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
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

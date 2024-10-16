

import 'package:flutter/material.dart';

class NoLoginAlertDialog extends StatelessWidget {
  const NoLoginAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('イベントの追加について'),
      content: const Text('イベントを追加するにはログインしてください'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

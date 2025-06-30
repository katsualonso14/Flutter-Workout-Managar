
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/presentation/widgets/dialog/delete_success_dialog.dart';

class CheckPasswordDialog extends StatelessWidget {
  const CheckPasswordDialog({Key? key, required this.parentContext}) : super(key: key);
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    void reauthenticateUser(BuildContext context, String password) async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          String email = user.email!;
          final credential = EmailAuthProvider.credential(email: email, password: password);
          await user.reauthenticateWithCredential(credential);

          if (context.mounted) {
            showDialog(
                context: context,
                builder: (context) {
                  return const DeleteSuccessDialog();
                });
          }

        } catch (e) {
          debugPrint('Re-authentication failed: $e');
        }
      }
    }

    return AlertDialog(
      title: const Text('削除するにはパスワードを入力してください'),
      content: TextField(
        controller: passwordController,
        decoration: const InputDecoration(labelText: 'Enter your password'),
        obscureText: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);  // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final password = passwordController.text;
            if (password.isNotEmpty) {
              Navigator.pop(context);  // Close the dialog
              reauthenticateUser(parentContext, password);  // Pass the parent context
            } else {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                const SnackBar(content: Text('Please enter a password')),
              );
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

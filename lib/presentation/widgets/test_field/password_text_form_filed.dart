
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/login_form_providers.dart';

class PasswordTextFormFiled extends ConsumerWidget {
  const PasswordTextFormFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPassword = ref.watch(passwordProvider.notifier);
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password(6 characters or more)'),
      // パスワードが見えないようにする
      obscureText: true,
      onChanged: (String value) {
        userPassword.state = value;
      },
    );
  }
}

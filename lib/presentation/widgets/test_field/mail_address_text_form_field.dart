
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_manager/presentation/controller/login_form_providers.dart';

class MailAddressTextFormField extends ConsumerWidget {
  const MailAddressTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(emailProvider.notifier);
    return TextFormField(
      // テキスト入力のラベルを設定
      decoration: const InputDecoration(labelText: 'Mail Address'),
      onChanged: (String value) {
        userEmail.state = value;
      },
    );
  }
}

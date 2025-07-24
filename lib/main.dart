import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_manager/core/firebase_options.dart';
import 'package:flutter_workout_manager/presentation/controller/auth_providers.dart';
import 'package:flutter_workout_manager/presentation/pages/login.dart';
import 'package:flutter_workout_manager/presentation/widgets/navigation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: App());
  }
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCheck = ref.watch(authStateProvider);

    return userCheck.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => const Scaffold(
              body: Center(
                child: Text('Error occurred while checking user status'),
              ),
            ),
        data: (data) {
          if (data == null) {
            return const LogIn();
          } else {
            return const Navigation();
          }
        });
  }
}

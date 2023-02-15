
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test')
        ),
        body: const Center(
          child: ElevatedButton(
              onPressed: null,
              child: Text('sample ')
          ),
        ),
      ),
    );
  }
}

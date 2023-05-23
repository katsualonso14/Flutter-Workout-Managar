
import 'package:flutter/material.dart';

import '../../data/repositories/firebase.dart';

class TestPage extends StatelessWidget {
   TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> id = ['CBJ1nH4CVXn16oYoGvND'];
    return Scaffold(
      body: FutureBuilder(
        future: FireStore.getEvent(),
        builder: (BuildContext context, snapshot){
          return Center(
            child: Column(
              children: [
                ElevatedButton(onPressed: (){
                  final doc = snapshot.data[0];
                  print('${doc.event}');
                },
                    child: Text('Button')
                ),
                Text('Text'),
              ],
            ),
          );
        },
      )
    );
  }
}
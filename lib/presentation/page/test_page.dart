
import 'package:flutter/material.dart';

import '../../data/repositories/firebase.dart';

class TestPage extends StatelessWidget {
   TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FireStore.firebaseEvents.snapshots(),
        builder: (BuildContext context, snapshot){
          return Center(
            child: Text(
              '${snapshot.data.docs[1]['event']}'
            ),
          );
        },
      )
    );
  }
}
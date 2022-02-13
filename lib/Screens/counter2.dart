import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:counter_app/main.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Counter2 extends StatefulWidget {
  const Counter2({Key? key}) : super(key: key);

  @override
  _Counter2State createState() => _Counter2State();
}

class _Counter2State extends State<Counter2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int counterText = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Counter>().getCount2();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<Counter>(context).pageSelectionIndex;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Counter $_selectedIndex'),
        ),
        actions: <Widget>[
          //-----Notification-Bell------------------
          Container(
              margin: const EdgeInsets.only(right: 0.0),
              child: IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () => context.read<Counter>().resetAll(),
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream:
                    _firestore.collection('Tab').doc('Counter2').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var output = snapshot.data!.data();
                    var value = output!['count'];

                    return Text(
                      value.toString(),
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text(
                "Increment me!",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                context.read<Counter>().incrementTab1();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
              ),
            ),
          ],
        ),
      ),
    );
  }
}

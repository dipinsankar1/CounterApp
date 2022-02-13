import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:counter_app/main.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Counter1 extends StatefulWidget {
  const Counter1({Key? key}) : super(key: key);

  @override
  _Counter1State createState() => _Counter1State();
}

class _Counter1State extends State<Counter1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int counterText = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Counter>().getCount1();
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
                    _firestore.collection('Tab').doc('Counter1').snapshots(),
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
                context.read<Counter>().increment();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
                onPrimary: Colors.white, // foreground
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

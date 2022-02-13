import 'package:flutter/material.dart';

import 'package:provider/src/provider.dart';
import 'package:counter_app/main.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Counter3 extends StatefulWidget {
  const Counter3({Key? key}) : super(key: key);

  @override
  _Counter3State createState() => _Counter3State();
}

class _Counter3State extends State<Counter3> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Counter>().getCount3();
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
                    _firestore.collection('Tab').doc('Counter3').snapshots(),
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
              onPressed: () => context.read<Counter>().incrementTab2(),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
            ),
          ],
        ),
      ),
    );
  }
}

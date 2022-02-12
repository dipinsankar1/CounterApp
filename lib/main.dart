import 'package:flutter/material.dart';
import 'package:counter_app/Screens/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

class Counter with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int pageSelectionIndex = 0;
  int _count = 0;
  int _count1 = 0;
  int _count2 = 0;
  int get count => _count;
  int get count1 => _count1;
  int get count2 => _count2;

  void getCount1() async {
    var collection = _firestore.collection('Tab');
    var docSnapshot = await collection.doc('Counter1').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['count']; // <-- The value you want to retrieve.
      _count = value;
      notifyListeners();
    }
  }

  void getCount2() async {
    var collection = _firestore.collection('Tab');
    var docSnapshot = await collection.doc('Counter2').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['count']; // <-- The value you want to retrieve.
      _count1 = value;
      notifyListeners();
    }
  }

  void getCount3() async {
    var collection = _firestore.collection('Tab');
    var docSnapshot = await collection.doc('Counter3').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['count']; // <-- The value you want to retrieve.
      _count2 = value;
      notifyListeners();
    }
  }

  void increment() {
    _count++;
    _firestore.collection('Tab').doc('Counter1').set(
      {'count': _count, 'timestamp': FieldValue.serverTimestamp()},
    );
    notifyListeners();
  }

  void incrementTab1() {
    _count1++;
    _firestore.collection('Tab').doc('Counter2').set(
      {'count': _count1, 'timestamp': FieldValue.serverTimestamp()},
    );
    notifyListeners();
  }

  void incrementTab2() {
    _count2++;
    _firestore.collection('Tab').doc('Counter3').set(
      {'count': _count2, 'timestamp': FieldValue.serverTimestamp()},
    );
    notifyListeners();
  }

  void updatePageSelection(int index) {
    pageSelectionIndex = index;
    notifyListeners();
  }

  void resetAll() {
    _count = 0;
    _count1 = 0;
    _count2 = 0;
    _firestore.collection('Tab').doc('Counter1').set(
      {'count': _count, 'timestamp': FieldValue.serverTimestamp()},
    );
    _firestore.collection('Tab').doc('Counter2').set(
      {'count': _count1, 'timestamp': FieldValue.serverTimestamp()},
    );
    _firestore.collection('Tab').doc('Counter3').set(
      {'count': _count2, 'timestamp': FieldValue.serverTimestamp()},
    );
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

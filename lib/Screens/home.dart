import 'package:flutter/material.dart';
import 'package:counter_app/Screens/counter1.dart';
import 'package:counter_app/Screens/counter2.dart';
import 'package:counter_app/Screens/counter3.dart';
import 'package:counter_app/main.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex = 0; // to keep track of active tab index
  final List<Widget> screens = [
    const Counter1(),
    const Counter2(),
    const Counter3(),
  ]; // to store nested tabs

  void onTabTapped(int index) {
    Provider.of<Counter>(context, listen: false).updatePageSelection(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex:
            _currentIndex, //// this will be set when a new tab is tapped
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Counter1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Counter2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Counter3',
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        // onPressed: () => context.read<Counter>().increment(),
        onPressed: () {
          if (_currentIndex == 0) {
            context.read<Counter>().increment();
          }
          if (_currentIndex == 1) {
            context.read<Counter>().incrementTab1();
          }
          if (_currentIndex == 2) {
            context.read<Counter>().incrementTab2();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}

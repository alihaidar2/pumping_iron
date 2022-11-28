import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/pages/test_page.dart';
import 'package:pumping_iron/pages/workout_list_page.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import 'package:pumping_iron/widgets/ExerciseEntry.dart';

// import 'package:pump_that_iron/models/set.dart' as sett;
// import 'package:pump_that_iron/globals.dart' as globals;

import '../main.dart';
import '../models/exercise.dart';
import '../models/set.dart';
import '../globals.dart' as globals;
import '../objectbox.g.dart';
import 'exercise_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Set> sets;

  int _selectedIndex = 0;

  // create static list of 8 Widgets
  static List<Widget> _widgetOptions = <Widget>[
    TestPage(title: 'Test'),
    WorkoutListPage(),
    // WorkoutPage(title: 'Workout'),
    ExerciseListPage(title: 'Exercises'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // query to return all exercise names
    // PropertyQuery<String> query =
    //     objectBox.setBox.query().build().property(Set_.exerciseName);
    // query.distinct = true;
    // List<String> exerciseNames = query.find();
    // query.close();
    //
    // // gets all sets
    // Query<Set> query2 = objectBox.setBox.query().build();
    // List<Set> sets = query2.find();
    // query2.close();

    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
          // child: const Text("_widgetOptions.elementAt(_selectedIndex)"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Workouts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Exercises',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }

  // create function to set the selectedindex of the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

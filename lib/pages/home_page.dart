import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/pages/test_page.dart';
import 'package:pumping_iron/pages/tools_page.dart';
import 'package:pumping_iron/pages/workout_list_page.dart';
import 'package:pumping_iron/pages/workout_plan_list_page.dart';
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

  // create static list of 3 Widgets
  static List<Widget> _widgetOptions = <Widget>[
    WorkoutPlanListPage(),
    ExerciseListPage(title: 'Exercises'),
    ToolsPage(title: 'Tools'),
  ];

  @override
  void initState() {
    super.initState();
    sets = objectBox.setBox.query().build().find();
    print('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.list),
            //   label: 'Exercises',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Tools',
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

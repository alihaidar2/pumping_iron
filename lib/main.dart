import 'dart:math';

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:pumping_iron/models/set.dart';
import 'package:pumping_iron/pages/exercise_list_page.dart';
import 'package:pumping_iron/pages/home_page.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import 'package:pumping_iron/services/objectbox.dart';

import 'models/exercise.dart';
import 'pages/test_page.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Pumping Iron'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String endpoint;
  late Future<List<Exercise>> futureExercises;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
                color: Colors.teal, fontWeight: FontWeight.bold)),
        // make the font cool
        leading: const Icon(Icons.gps_fixed, color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 30),
            ),
            const Text(
              "to the app",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 20),
            ),
            // create a teal button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Begin'),
            ),
          ],
        ),
      ),
      // create bottom navigation bar
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Exercises',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.whatshot),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       label: 'Workouts',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.face_outlined),
      //       label: 'Test2',
      //     ),
      //   ],
      //   currentIndex: 0,
      //   selectedItemColor: Colors.red,
      //   unselectedItemColor: Colors.grey,
      //   onTap: _onItemTapped,
      // ),
    );
  }


}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          // dont need the message, but it is used if you want to return something from that page
          child: const Text("List of Exercises from API"),
          onPressed: () async {
            var message = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return const ExerciseListPage(title: 'Exercise List Page');
            }));
            print(message);
          },
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const WorkoutPage(title: 'Workout Page');
              }));
            },
            child: const Text("To Workout Page (WIP)")),
        TextButton(
            onPressed:
                // null,
                () {
              objectBox.setBox.removeAll();
            },
            child: const Text("Clear DB")),
        TextButton(
            onPressed:
                // null,
                () {
              List<Set> sets = objectBox.setBox.getAll();
              Set set = Set(
                  exerciseName: 'Rows',
                  repetitions: Random().nextInt(8),
                  date: DateTime.now());
              objectBox.setBox.put(set);
            },
            child: const Text("Add Rows")),
        TextButton(
            onPressed: () {
              List<Set> sets = objectBox.setBox.getAll();
              Set set = Set(
                  exerciseName: 'Deadlift',
                  repetitions: Random().nextInt(6),
                  date: DateTime.now());
              objectBox.setBox.put(set);
            },
            child: const Text("Add Deadlift")),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const TestPage(title: 'Workout Page');
              }));
            },
            child: const Text("Pull Day")),
      ],
    );
  }
}

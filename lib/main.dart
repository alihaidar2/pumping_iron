import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:pumping_iron/pages/exercise_list_page.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import 'package:pumping_iron/services/objectbox.dart';

import 'models/exercise.dart';

late ObjectBox objectBox;

Future main() async {
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              // dont need the message, but it is used if you want to return something from that page
              child: const Text("Next"),
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
                child: const Text("To Database Page"))
          ],
        ),
      ),
    );
  }
}

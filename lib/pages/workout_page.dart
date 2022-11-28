import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/exercise.dart';
import '../models/set.dart';
import '../globals.dart' as globals;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late List<Exercise> streamExercises;
  late List<Set> sets;

  @override
  void initState() {
    super.initState();
    sets = objectBox.setBox.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: sets.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Set: ${sets[index].date.day}"),
            ),
          );
          //   ListTile(
          //   title: Text(
          //       "${sets[index].date.day}/${sets[index].date.month} ${sets.length} ${sets[index].id} - ${sets[index].exerciseName} - ${sets[index].repetitions} Rep(s)  @ ${sets[index].date.hour}:${sets[index].date.minute}:${sets[index].date.second}"),
          // );
        },
      ),
    );
  }
}

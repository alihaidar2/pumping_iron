import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:pump_that_iron/models/set.dart' as sett;
// import 'package:pump_that_iron/globals.dart' as globals;

import '../main.dart';
import '../models/exercise.dart';
import '../models/set.dart';
import '../globals.dart' as globals;

// import 'package:pump_that_iron/objectbox.g.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late List<Exercise> streamExercises;
  late List<Set> sets;
  // change this to streamSets
  // late List<Exercise> streamExercises;

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
          // setState(() {
            // objectBox.exerciseBox.putMany(streamExercises);
          // });
          return ListTile(
            title: Text(
                    sets[index].exerciseName.toString() + " - " +
                    sets[index].repetitions.toString() + " Rep(s)  @ "
                    // there's a way to format this
                    + sets[index].date.hour.toString() + ":" + sets[index].date.minute.toString() + ":" +sets[index].date.second.toString()
            ),
          );
        },
      ),
    );
  }
}

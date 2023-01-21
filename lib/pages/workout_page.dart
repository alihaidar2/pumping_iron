import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/models/exercise.dart';
import 'package:pumping_iron/objectbox.g.dart';
import 'package:pumping_iron/widgets/ExerciseEntry.dart';

import '../main.dart';
import '../models/set.dart';


class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.workoutId, required this.dateTime}) : super(key: key);
  // WORKOUT PAGE IS A LIST OF SETS
  // I need all of the sets on this day which is why I use the DateTime
  final int workoutId;
  final DateTime dateTime;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late int workoutId;
  late DateTime dateTime;
  late List<Set> sets;
  late var exercises;

  @override
  void initState() {
    super.initState();
    // get all of the exercises on this date
    Query<Set> query = objectBox.setBox.query(
        Set_.workoutId.equals(widget.workoutId)
    ).build();

    sets = query.find(); // this gets me all sets
    exercises = groupSetsByExerciseName(sets); // this gets sets grouped by name
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // this will be a listview of the cards you created
      body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (BuildContext context, int index) {
            // Exercise exercise = exercises.elementAt(index);
            // I only want the exercise entries to show
            // the exercises that are part of this workoutId
            // return Text("index.toString()");
            return ExerciseEntry(name: "exercise.name!", exerciseId: 2, day: 19, month:1, year:2023);

          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // need to find out how to get the workoutId and date from instance
        Set newSet = Set(exerciseId: 2, repetitions: 12, workoutId: widget.workoutId, date: widget.dateTime);
        objectBox.setBox.put(newSet);
        setState(() {
          sets = objectBox.setBox.query(
              Set_.workoutId.equals(widget.workoutId)
          ).build().find();
        });

      },),
    );
  }

  Iterable<String?> groupSetsByExerciseName(List<Set> sets) {
    final dates = groupBy(sets, (Set s) {
      return objectBox.getExerciseById(s.exerciseId!).name;
    });

    return dates.keys;
  }

}

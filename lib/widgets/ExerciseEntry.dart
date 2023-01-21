import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pumping_iron/models/exercise.dart';
import 'package:pumping_iron/models/set.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../objectbox.g.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class ExerciseEntry extends StatefulWidget {
  final String name;
  final int exerciseId;
  final int? year;
  final int? month;
  final int? day;


  ExerciseEntry({required this.name, required this.exerciseId, this.year, this.month, this.day});

  @override
  State<ExerciseEntry> createState() => _ExerciseEntryState();
}

class _ExerciseEntryState extends State<ExerciseEntry> {
  List<Set> sets = [];
  late List<Exercise> exercises;
  late String exerciseName;


  @override
  void initState() {
    super.initState();

    // gets all sets for a single exercise
    sets = objectBox.setBox.query(Set_.exerciseId.equals(widget.exerciseId)).build().find().toList();

    // get Exercise Name from query to database with set(0)
    exerciseName = objectBox.getExerciseById(sets.elementAt(0).id).name;

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  // Exercise name
                  Expanded(
                    child: Text(
                      exerciseName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const VerticalDivider(width: 1.0),
                  // Exercise sets
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: sets.length,
                          // number of sets belonging to an Exercise
                          itemBuilder: (context, index) {
                            return Text(
                                "Set ${index + 1} : ${sets.elementAt(index).repetitions} rep(s) ");
                          }),
                    ),
                  ),
                ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  groupSetsByExercise(List<Set> sets) {
    final exercises = groupBy(sets, (Set s) {
      return objectBox.getExerciseById(s.exerciseId!).id;
    });
    return exercises;
  }
}

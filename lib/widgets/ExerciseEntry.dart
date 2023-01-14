import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final int year;
  final int month;
  final int day;


  ExerciseEntry({required this.name, required this.year,required this.month,required this.day});

  @override
  State<ExerciseEntry> createState() => _ExerciseEntryState();
}

class _ExerciseEntryState extends State<ExerciseEntry> {
  List<Set> sets = [];
  late var exercises;


  @override
  void initState() {
    super.initState();

    sets = objectBox.setBox.query().build().find().toList();
    sets = sets.where((element) => element.exerciseName == widget.name && element.date.year == widget.year && element.date.month == widget.month && element.date.day == widget.day).toList();
    // have to do it for a certain name

    // todaySets gets you all the sets of every exercise
    // I need to group each exercise with its sets

    // list of sets for a single exercise
    exercises = groupSetsByExerciseName(sets);

    print("object");

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
                // crossAxisAlignment: CrossAxisAlignment.start, // for left side
                children: [
                  // Exercise name
                  Expanded(
                    child: Text(
                      widget.name!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1.0,
                  ),
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

  Iterable<String> groupSetsByExerciseName(List<Set> sets) {
    final dates = groupBy(sets, (Set s) {
      return s.exerciseName;
    });

    return dates.keys;
  }

}

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

  ExerciseEntry({required this.name});

  @override
  State<ExerciseEntry> createState() => _ExerciseEntryState();
}

class _ExerciseEntryState extends State<ExerciseEntry> {
  List<Set> sets = [];

  @override
  void initState() {
    super.initState();
    sets = objectBox.setBox
        .query(Set_.exerciseName.equals(widget.name))
        .build()
        .find();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      sets = objectBox.setBox
          .query(Set_.exerciseName.equals(widget.name))
          .build()
          .find();
    });
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
                            // return Text("Set ${index + 1} :  ${index + 7} rep(s) ");
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
}

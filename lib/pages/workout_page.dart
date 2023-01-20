import 'package:flutter/material.dart';
import 'package:pumping_iron/objectbox.g.dart';

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

  @override
  void initState() {
    super.initState();
    // get all of the exercises on this date
    Query<Set> query = objectBox.setBox.query(
      // Set_.exerciseId.equals(widget.exerciseId) &
        Set_.workoutId.equals(widget.workoutId)
    ).build();

    // can either make it so that
    // it gets me all of the exercices on a certain day OR
    // make sure the exercises/sets added have the EXACT SAME DATETIME
    sets = query.find();

    // fix this to make it get all sets with a workoutid and on this day
    // sets = objectBox.setBox.query(Set_.date.equals(widget.dateTime)).build().find().toList();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: sets.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(child: Text(sets.elementAt(index)..toString()));

          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // need to find out how to get the workoutId and date from instance
        Set newSet = Set(exerciseId: 2, repetitions: 12, workoutId: widget.workoutId, date: widget.dateTime);
        objectBox.setBox.put(newSet);
        setState(() {});

      },),
    );
  }
}

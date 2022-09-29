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
    // streamExercises = objectBox.getExercises();
    // streamExercises = globals.exerciseList;
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
            title: Text(sets[index].id.toString() + " - "
                + sets[index].date.second.toString() + " - "
                + sets[index].repetitions.toString()),
          );
        },
      ),
      // body: StreamBuilder<List<Exercise>>(
      //   stream: streamExercises,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       final exercises = snapshot.data!;
      //       return ListView.builder(
      //         itemCount: exercises.length,
      //         itemBuilder: (context, index) {
      //           final exercise = exercises[index];
      //
      //           return ListTile(
      //             title: Text(exercise.name!),
      //             subtitle: Text(exercise.target!),
      //             // trailing: IconButton(
      //             //   icon: const Icon(Icons.delete),
      //             //   onPressed: () => objectBox.deleteExercise(exercise.id!),
      //             // ),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Set newSet = Set(repetitions: 10999, date: DateTime.now());
            objectBox.setBox.put(newSet);
            sets = objectBox.setBox.getAll();
          });
          // final sett.Set set = sett.Set(repetitions: 4,);
          // final sett.Set set = Set(4) as sett.Set;
          // generate list of exercises
          // final exercise = Exercise(
          //     name: "Bench Press",
          //     target: "Chest",
          //     bodyPart: "Middle Chest",
          //     equipment: "Barbell and Bench",
          //     gifUrl: "L"
          // );
          // objectBox.exerciseBox.put(exercise);
          // objectBox.exerciseBox.removeAll();

          // setState(() {
            // streamExercises = objectBox.getExercises();
          // });

          // initState();
          // objectBox.insertExercise(exercise);
        },
      ),
    );
  }
}

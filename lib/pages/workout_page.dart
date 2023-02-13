import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/models/exercise.dart';
import 'package:pumping_iron/objectbox.g.dart';
import 'package:pumping_iron/widgets/ExerciseEntry.dart';
import 'package:pumping_iron/widgets/add_set_dialog.dart';

import '../main.dart';
import '../models/set.dart';
import '../widgets/add_workout_plan_dialog.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.workoutId, required this.dateTime})
      : super(key: key);

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
  late Map<String, List<Set>> exercises;
  late List<Exercise> testExercises;
  late String exerciseToAdd;

  @override
  void initState() {
    super.initState();
    exerciseToAdd = "pectorals";
    // get all of the exercises on this date
    Query<Exercise> query2 = objectBox.exerciseBox
        .query(Exercise_.name
            .equals("barbell bench press")
            .or(Exercise_.name.equals("barbell incline bench press")))
        .build();
    Query<Exercise> query3 = objectBox.exerciseBox
        .query(Exercise_.target.equals(exerciseToAdd))
        .build();
    testExercises = query3.find();

    Query<Set> query =
        objectBox.setBox.query(Set_.workoutId.equals(widget.workoutId)).build();
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
            List<Set> sets = exercises.values.elementAt(index);
            // return Text(exerciseName);
            return ExerciseEntry(
              exerciseId: sets.first.exerciseId!,
              workoutId: widget.workoutId,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddSetDialog();
            },
          );
        },
        // onPressed: () {
        //   var alert = AlertDialog(
        //     title: Text("How many items do you need?"),
        //     content: TextField(
        //       style: TextStyle(
        //           decoration: TextDecoration.none),
        //       maxLines: 1,
        //       autofocus: false,
        //       enabled: true,
        //       onSubmitted: (String text) {
        //         int number_input = int.parse(text);
        //         // Do something with your number like pass it to the next material page route
        //       },
        //       // controller: _repsController,
        //       decoration: new InputDecoration(
        //         errorStyle: TextStyle(color: Colors.redAccent),
        //         border: new UnderlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Color.fromRGBO(40, 40, 40, 1.0),),
        //           borderRadius: BorderRadius.circular(10.0),),
        //         focusedBorder: UnderlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Color.fromRGBO(40, 40, 40, 1.0),),
        //           borderRadius: BorderRadius.circular(10.0),),
        //         disabledBorder: UnderlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Color.fromRGBO(40, 40, 40, 1.0),),
        //           borderRadius: BorderRadius.circular(10.0),),
        //         prefixIcon: new Icon(
        //           Icons.playlist_add,
        //           size: 18.0,),),),);
        //
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return alert;
        //     },);
        // },
        // onPressed: () async {
        //   // 1. open an alert dialog and ask which muscle they are trying to target
        //   // from a list of them - chest, back, legs
        //   String muscleName = await showDialog(
        //       context: context,
        //       builder: (context) => SimpleDialog(
        //             title: Text("Select a muscle"),
        //             titlePadding: const EdgeInsets.all(24),
        //             children: getMuscleChoices(),
        //           ));
        //
        //   // 2. now I have the muscle name, get all exercises hit by it
        //   List<Exercise>? targetExercises = getExercisesFromSelection(muscleName); //objectBox.getExercisesByTarget(target);
        //
        //   // 3. Now I have all of the exercises, create dialogs from them
        //   // Exercise? ex = await chooseAnExercise(targetExercises!);
        //   // List testExercises
        //
        //   String exerciseName = await showDialog(
        //       context: context,
        //       builder: (context) => SimpleDialog(
        //             title: Text("Select an Exercise"),
        //             titlePadding: const EdgeInsets.all(24),
        //             children: getExerciseOptions(targetExercises),
        //           ));
        //
        //   // 4. Now ask how many reps
        //   int reps = await showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //         title: Text("How many items do you need?"),
        //         content: TextField(
        //           style: TextStyle(
        //               decoration: TextDecoration.none),
        //           maxLines: 1,
        //           autofocus: false,
        //           enabled: true,
        //           onSubmitted: (String text) {
        //             int number_input = int.parse(text);
        //             // return number_input;
        //             // Do something with your number like pass it to the next material page route
        //           },
        //           // controller: _repsController,
        //           decoration: new InputDecoration(
        //             errorStyle: TextStyle(color: Colors.redAccent),
        //             border: new UnderlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: Color.fromRGBO(40, 40, 40, 1.0),),
        //               borderRadius: BorderRadius.circular(10.0),),
        //             focusedBorder: UnderlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: Color.fromRGBO(40, 40, 40, 1.0),),
        //               borderRadius: BorderRadius.circular(10.0),),
        //             disabledBorder: UnderlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: Color.fromRGBO(40, 40, 40, 1.0),),
        //               borderRadius: BorderRadius.circular(10.0),),
        //             prefixIcon: new Icon(
        //               Icons.playlist_add,
        //               size: 18.0,),),),));
        //
        //
        //   // int exercise
        //
        //   // 5. Now we take the exercise found and create a set
        //
        //   // 1. query to find exercise Id
        //   int exerciseId = objectBox.getExerciseByName(exerciseName).id;
        //   // 2. create a set with this workoutId and a number of sets
        //   Set set = new Set(
        //       exerciseId: exerciseId,
        //       workoutId: widget.workoutId,
        //       repetitions: 3,
        //       date: DateTime.now());
        //   objectBox.addSet(set);
        //   setState(() {
        //     Query<Exercise> query = objectBox.exerciseBox
        //         .query(Exercise_.target.equals(exerciseToAdd))
        //         .build();
        //     testExercises = query.find();
        //     Query<Set> query2 = objectBox.setBox
        //         .query(Set_.workoutId.equals(widget.workoutId))
        //         .build();
        //     sets = query2.find(); // this gets me all sets
        //     exercises = groupSetsByExerciseName(sets);
        //   });
        // },
      ),
    );
  }

  // returns map of exercise names with all of their sets in a list
  Map<String, List<Set>> groupSetsByExerciseName(List<Set> sets) {
    final dates = groupBy(sets, (Set s) {
      return objectBox.getExerciseById(s.exerciseId!).name;
    });
    return dates;
  }

  // gets options for exercise selected
  List<SimpleDialogOption> getExerciseOptions(List<Exercise>? exercises) {
    List<SimpleDialogOption> widgets = [];
    // create the widgets based off of testExercises
    for (int i = 0; i < exercises!.length; i++) {
      String exerciseName = exercises.elementAt(i).name;
      widgets.add(SimpleDialogOption(
        child: Text(exerciseName.toTitleCase()),
        onPressed: () {
          Navigator.pop(context, exerciseName);
        },
      ));
    }
    return widgets;
  }

  // gets options for exercise selected
  List<SimpleDialogOption> getMuscleChoices() {
    List<String> muscles = [];
    muscles.add("chest");
    muscles.add("back");
    muscles.add("shoulders");
    muscles.add("legs");
    muscles.add("biceps");
    muscles.add("triceps");

    List<SimpleDialogOption> muscleOptions = [];
    // create the widgets based off of testExercises
    for (int i = 0; i < muscles.length; i++) {
      String muscle = muscles.elementAt(i);
      muscleOptions.add(SimpleDialogOption(
        child: Text(muscle.toTitleCase()),
        onPressed: () {
          Navigator.pop(context, muscle);
        },
      ));
    }
    return muscleOptions;
  }

  // get all exercises based off of muscle chosen
  // List<Exercise>? getExercisesFromSelection(String target) {
  //   switch (target) {
  //     case "chest":
  //       return objectBox.getExercisesByTarget('pectorals');
  //     case "back":
  //       List<Exercise> exercises = [];
  //       exercises.addAll(objectBox.getExercisesByBodyPart('back'));
  //       exercises.addAll(objectBox.getExercisesByBodyPart('neck'));
  //       return exercises;
  //     case "shoulders":
  //       return objectBox.getExercisesByBodyPart('shoulders');
  //     case "legs":
  //       List<Exercise> exercises = [];
  //       exercises.addAll(objectBox.getExercisesByBodyPart('lower legs'));
  //       exercises.addAll(objectBox.getExercisesByBodyPart('upper legs'));
  //       return exercises;
  //     case "biceps":
  //       return objectBox.getExercisesByTarget('biceps');
  //     case "triceps":
  //       return objectBox.getExercisesByTarget('triceps');
  //     default:
  //       return null;
  //   }
  // }

}

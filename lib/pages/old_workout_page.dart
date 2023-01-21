// import 'dart:math';
//
// import 'package:collection/collection.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../main.dart';
// import '../models/exercise.dart';
// import '../models/set.dart';
// import '../globals.dart' as globals;
// import '../objectbox.g.dart';
// import '../widgets/ExerciseEntry.dart';
//
// class OldWorkoutPage extends StatefulWidget {
//   const OldWorkoutPage({Key? key, required this.title, required this.year,required this.month,required this.day}) : super(key: key);
//   final String title;
//   final int year;
//   final int month;
//   final int day;
//   // final dynamic dates;
//
//   @override
//   State<OldWorkoutPage> createState() => _OldWorkoutPageState();
// }
//
// class _OldWorkoutPageState extends State<OldWorkoutPage> {
//   late List<String?> exerciseNames;
//   late List<Set> sets;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // filter to the sets for the day
//     sets = sets.where((element) => element.date.year == widget.year && element.date.month == widget.month && element.date.day == widget.day).toList();
//     exerciseNames = groupSetsByExercises(sets);
//     // exerciseNames = ['Deadlift', 'Pullups'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         children: [
//           Text(widget.year.toString()+"/"+widget.month.toString()+"/"+widget.day.toString()),
//           Expanded(
//             child: ListView.builder(
//               // itemCount: exerciseNames.length,
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return ExerciseEntry(name: "exercise.name!",exerciseId: 1, year: widget.year, month: widget.month, day: widget.day);
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           List<Set> sets = objectBox.setBox.getAll();
//           Set set = Set(
//               exerciseId: objectBox.getExerciseByName("Deadlift").id,
//               workoutId: null,
//               repetitions: Random().nextInt(6),
//               date: DateTime.now());
//           objectBox.setBox.put(set);
//           // sets = sets.where((element) => element.date.year == widget.year && element.date.month == widget.month && element.date.day == widget.day).toList();
//           setState(() {
//           });
//         },
//
//       ),
//     );
//   }
//
//   // this isnt gonna exist anymore -- wont need to
//   List<String?> groupSetsByExercises(List<Set> sets) {
//     final exercises = groupBy(sets, (Set s) {
//       return objectBox.getExerciseById(s.exerciseId).name; // return the name of the set
//     });
//
//     List<String?> strings = exercises.keys.toList();
//
//     return strings;
//   }
//
// }

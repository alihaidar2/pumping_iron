import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:pumping_iron/pages/test_page.dart';
import 'package:pumping_iron/pages/old_workout_page.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import '../main.dart';
import '../models/set.dart';
import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../objectbox.g.dart';

class WorkoutListPage extends StatefulWidget {
  int workoutPlanId;

  WorkoutListPage({Key? key, required this.workoutPlanId}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late String title;
  late List<Workout> workouts;

  final exerciseNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    title = "Workout List Page";
    // workouts = objectBox.getAllWorkouts();
    // this needs to be getting workouts based off of a workoutId
    Query<Workout> query = objectBox.workoutBox.query(
        Workout_.workoutPlanId.equals(widget.workoutPlanId)
    ).build();
    workouts = query.find();
  }

  @override
  Widget build(BuildContext context) {
    // ListView of setDates
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (BuildContext context, int index) {
            var workout = workouts.elementAt(index);
            return Container(
              height: 50,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutPage(
                          workoutId: workout.id,
                          dateTime: workout.dateTime,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: new Text(workout.workoutName,
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Iterable<DateTime> groupSetsByDate(List<Set> sets) {
    final dates = groupBy(sets, (Set s) {
      // this needs to group by day month and year not just date
      // I'll just have to reform the date
      // create date from sd.date.day
      return s.date;
    });

    return dates.keys;
  }

  String cleanDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

// Future<void> _displayTextInputDialog(BuildContext context) async {
//   // will have to find a way to use this to create a workout too
//   // either a separate one or do the same thing with a different case
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('TextField in Dialog'),
//           content: TextField(
//             onChanged: (value) {
//               setState(() {
//                 exerciseNameValue = value;
//               });
//             },
//             controller: exerciseNameController,
//             decoration: InputDecoration(hintText: "Text Field in Dialog"),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               child: Text('CANCEL'),
//               onPressed: () {
//                 setState(() {
//                   Navigator.pop(context);
//                 });
//               },
//             ),
//             ElevatedButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   exerciseName = exerciseNameValue;
//                   Navigator.pop(context);
//                 });
//               },
//             ),
//           ],
//         );
//       });
// }

}

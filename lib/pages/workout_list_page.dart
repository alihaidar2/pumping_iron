import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import 'package:pumping_iron/widgets/add_workout_dialog.dart';

import '../main.dart';
import '../models/set.dart';
import '../models/workout.dart';
import '../objectbox.g.dart';

class WorkoutListPage extends StatefulWidget {
  final int workoutPlanId;

  const WorkoutListPage({Key? key, required this.workoutPlanId}) : super(key: key);

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
    Query<Workout> query = objectBox.workoutBox
        .query(Workout_.workoutPlanId.equals(widget.workoutPlanId))
        .build();
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
            return SizedBox(
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
                        child: Text(
                          workout.workoutName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddWorkoutDialog(workoutBox: objectBox.workoutBox, workoutPlanId: widget.workoutPlanId);
            },
          );
          setState(() { workouts = objectBox.getWorkoutsByWorkoutPlanId(widget.workoutPlanId); }); // will have to change this to get only for a certain id
          // objectBox.getWorkoutsById(workoutPlanId)
        },
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
}

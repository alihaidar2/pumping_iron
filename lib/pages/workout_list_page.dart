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
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late String title;
  late List<Set> sets;
  late List<Workout> workouts;
  late List<List<Set>> setDates;
  late List<String> days;
  late var dates;

  late String exerciseNameValue;
  late String exerciseName;

  final exerciseNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    title = "Workouts";
    sets = objectBox.setBox.query().build().find().toList();
    workouts = objectBox.workoutBox.query().build().find().toList();
    exerciseName = "naem";
    // get a list of all dates, grouped by day
    // dates = groupSetsByDate(sets);
  }

  @override
  Widget build(BuildContext context) {
    print(exerciseName);
    // ListView of setDates
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (BuildContext context, int index) {
            var workout = workouts.elementAt(index);
            return ListTile(
              title: Text(workout.workoutName),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              //onTap calls When ListTile Taps
              onTap: () {
                // // Navigator pushes Workout for that date.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutPage(workoutId: workout.id, dateTime: workout.dateTime,),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _displayTextInputDialog(context);
          Workout workout = new Workout(dateTime: DateTime.now(), workoutName: '');
          objectBox.workoutBox.put(workout);
          setState(() {
            workouts = objectBox.workoutBox.query().build().find().toList();
          });
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

  String cleanDate(DateTime date) {
    return date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    // will have to find a way to use this to create a workout too
    // either a separate one or do the same thing with a different case
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  exerciseNameValue = value;
                });
              },
              controller: exerciseNameController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    exerciseName = exerciseNameValue;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:pumping_iron/widgets/ExerciseEntry.dart';
import 'package:pumping_iron/widgets/Tool.dart';

// import 'package:pump_that_iron/models/set.dart' as sett;
// import 'package:pump_that_iron/globals.dart' as globals;

import '../main.dart';
import '../models/exercise.dart';
import '../models/set.dart';
import '../globals.dart' as globals;
import '../objectbox.g.dart';
import '../services/api_service.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final _formKey = GlobalKey<FormState>();
  final exerciseController = TextEditingController();
  final setController = TextEditingController();
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  late List<Set> sets;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // create columns with full length buttons
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(5),
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 2.5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[500],
                    ),
                    child: Center(
                        child: TextButton(
                            child: Text('Delete All Sets'),
                            onPressed: deleteAllSets)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[400],
                    ),
                    child: Center(
                        child: TextButton(
                            child: Text('Delete All Workouts'),
                            onPressed: deleteAllWorkouts)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 2.5,
                      bottom: 2.5,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[500],
                    ),
                    // color: Colors.grey[500],
                    child: Center(
                        child: TextButton(
                            child: Text('Add Sample Sets'),
                            onPressed: addSampleSets)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[400],
                    ),
                    child: Center(
                        child: TextButton(
                      child: Text('Add a Set'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  // overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: exerciseController,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "What is the name of the exercise?"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: setController,
                                              decoration: const InputDecoration(
                                                  labelText: "How many reps?"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      title: const Text(''),
                                                      subtitle: TextFormField(
                                                        controller:
                                                            dayController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText: 'DD'),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListTile(
                                                      title: const Text(''),
                                                      subtitle: TextFormField(
                                                        controller:
                                                            monthController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText: 'MM'),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListTile(
                                                      title: const Text(''),
                                                      subtitle: TextFormField(
                                                        controller:
                                                            yearController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    'YYYY'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: const Text("Submit"),
                                              onPressed: () {


                                                addSet(
                                                    exerciseController.text,
                                                    int.parse(
                                                        setController.text),
                                                    int.parse(
                                                        yearController.text),
                                                    int.parse(
                                                        monthController.text),
                                                    int.parse(
                                                        dayController.text));
                                                print(exerciseController.text);
                                                print(setController.text);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2.5,bottom: 2.5,),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[500],
                    ),
                    child: Center(
                        child: TextButton(
                            child: Text('Pull Exercises to Database'),
                            onPressed: pullExercisesToDatabase)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  // function to delete all sets
  void deleteAllSets() {
    objectBox.setBox.removeAll();
  }

  void deleteAllWorkouts() {
    objectBox.workoutBox.removeAll();
  }

  // barbell bench press, barbell incline bench press
  // pull-up, alternate lateral pulldown
  // barbell full zercher squat, barbell front squat
  void addSampleSets() {
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("barbell deadlift").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 27));
      objectBox.setBox.put(set);
    }
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("pull-up").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 27));
      objectBox.setBox.put(set);
    }
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("barbell bench press").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 28));
      objectBox.setBox.put(set);
    }
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("barbell incline bench press").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 28));
      objectBox.setBox.put(set);
    }
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("barbell full zercher squat").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 28));
      objectBox.setBox.put(set);
    }
    for (int i = 0; i < 4; i++) {
      Set set = Set(
          exerciseId: objectBox.getExerciseByName("barbell front squat").id,
          workoutId: null,
          repetitions: Random().nextInt(6),
          date: new DateTime(2012, 2, 28));
      objectBox.setBox.put(set);
    }

    var box = objectBox.exerciseBox.getAll();
    print('object');

  }

  //implement a function to add a set to the database
  void addSet(String exercise, int reps, int year, int month, int day) {
    // create a new set
    DateTime date = DateTime(year, month, day);
    Set newSet = new Set(exerciseId: objectBox.getExerciseByName(exercise).id, workoutId: null, repetitions: reps, date: date);
    objectBox.setBox.put(newSet);
  }

  Future<void> pullExercisesToDatabase() async {
    ApiService apiService = ApiService();
    String endpoint = 'exercises';
    var futureExercises = apiService.get(endpoint: endpoint);
    List<Exercise> list = await futureExercises;
    for (Exercise exercise in list) {
      objectBox.exerciseBox.put(exercise);
    }
    // objectBox.exerciseBox.putMany(list.toList());
    print('object');
  }
}

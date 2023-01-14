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
                children: [
                  TextButton(
                    onPressed: () {
                      deleteAllSets();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // for left side
                                children: [
                                  Text(
                                    "Delete all sets",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: ElevatedButton(
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
                                        child: CircleAvatar(
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
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: exerciseController,
                                              decoration: new InputDecoration(
                                                  labelText:
                                                      "What is the name of the exercise?"),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: setController,
                                              decoration: new InputDecoration(
                                                  labelText: "How many sets?"),
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
                                                      title: Text(''),
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
                                                      title: Text(''),
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
                                                      title: Text(''),
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
                                              child: Text("Submit"),
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
                      child: Text("Add a set"),
                    ),
                  ),
                  // Center(
                  //   child: ,
                  // ),
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

  //implement a function to add a set to the database
  void addSet(String exercise, int reps, int year, int month, int day) {
    // create a new set
    DateTime date = DateTime(year, month, day);
    Set newSet = new Set(exerciseName: exercise, repetitions: reps, date: date);
    objectBox.setBox.put(newSet);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/exercise.dart';
import '../services/api_service.dart';
import '../widgets/ExerciseRow.dart';
import '../globals.dart' as globals;

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  late Future<List<Exercise>> futureExercises;

  // late Future<List<String>> futureTargets;
  late String endpoint;
  late List<Exercise> exercises;
  String dropdownValue = 'Filter exercises by...';

  @override
  void initState() {
    super.initState();
    // initialize api service
    ApiService apiService = ApiService();
    endpoint = 'exercises';
    futureExercises = apiService.get(endpoint: endpoint);

    exercises = objectBox.getAllExercises();
  }

  void updateList(String? newValue) {
    dropdownValue = newValue!;
    switch (newValue) {
      case 'Filter exercises by...':
        break;
      default:
        exercises = objectBox.getExercisesByTarget(newValue);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  onChanged: (String? newValue) {
                    setState(() {
                      updateList(newValue);
                    });
                  },
                  items: getTargets(),
                ),
              ),
            ),
            ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                // itemCount: 20,
                itemCount: exercises.length > 20 ? 20 : exercises.length,
                // this would be come the length of the list with the data
                itemBuilder: (context, i) {
                  Exercise element = exercises.elementAt(i);
                  return ExerciseRow(
                      element.name, element.target, element.gifUrl);
                }),
          ],
        )
    );
  }
}

List<DropdownMenuItem<String>> getTargets() {
  // this is gonna be a API fetch or maybe conditional ...
  return [
    'Filter exercises by...',
    'abductors',
    'abs',
    'adductors',
    'biceps',
    'calves',
    'cardiovascular system',
    'delts',
    'forearms',
    'glutes',
    'hamstrings',
    'lats',
    'levator scapulae',
    'pectorals',
    'quads',
    'serratus anterior',
    'spine',
    'traps',
    'triceps',
    'upper back'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
        value: value, child: Text(value.toTitleCase()));
  }).toList();
}

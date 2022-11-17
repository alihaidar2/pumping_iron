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
  late Future<List<String>> futureTargets;
  late String endpoint;
  String dropdownValue = 'Filter exercises by...';

  @override
  void initState() {
    super.initState();
    // initialize api service
    ApiService apiService = ApiService();
    endpoint = 'exercises';
    futureExercises = apiService.get(endpoint: endpoint);
  }

  void updateList(String? newValue) {
    dropdownValue = newValue!;
    switch (newValue) {
      case 'Filter exercises by...':
        endpoint = 'exercises';
        break;
      default:
        endpoint = 'exercises/target/' + dropdownValue;
        break;
    }
    ApiService apiService = ApiService();
    futureExercises = apiService.get(endpoint: endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // const Text("Exercises", style: TextStyle(backgroundColor: Colors.teal, fontSize: 30, fontWeight: FontWeight.bold)),
          // Child 1 : Drowpdown
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
          FutureBuilder<List<Exercise>>(
              future: futureExercises,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 1000) {
                    globals.exerciseList = snapshot.data!;
                  }
                  // setState(() {
                  // objectBox.exerciseBox.putMany(snapshot.data!.sublist(0,10));
                  // });

                  return ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: 20,
                      itemCount: snapshot.data!.length > 20
                          ? 20
                          : snapshot.data!.length,
                      // this would be come the length of the list with the data
                      itemBuilder: (context, i) {
                        Exercise element = snapshot.data!.elementAt(i);
                        return ExerciseRow(
                            element.name, element.target, element.gifUrl);
                      });
                } else if (snapshot.hasError) {
                  return const Text("Error buddy");
                }
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
      // ),
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

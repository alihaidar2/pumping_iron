import 'package:flutter/material.dart';
import 'package:pumping_iron/models/exercise.dart';
import 'package:pumping_iron/services/string_utils.dart';
import 'package:pumping_iron/services/utils.dart';

class AddSetDialog extends StatefulWidget {
  const AddSetDialog({super.key});

  @override
  _AddSetDialogState createState() => _AddSetDialogState();
}

class _AddSetDialogState extends State<AddSetDialog> {
  late String _selectedOption1;
  late String _selectedOption2;

  List<String> muscleGroups = [
    "chest",
    "back",
    "legs",
    "shoulders",
    "biceps",
    "triceps"
  ];

  List<Exercise> exercises = [];

  late int _numberValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add a set'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text('Select a muscle group...'),
                  items: muscleGroups
                      .map((option) => DropdownMenuItem(
                          value: option, child: Text(option.toTitleCase())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOption1 = value!;
                      exercises = Utils.getExercisesFromSelection(value)!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text('Select exercise...'),
                  items: exercises
                      .map((option) =>
                          DropdownMenuItem(value: option, child: Text(option.name.toTitleCase())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOption2 = value!.name;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _numberValue = int.parse(value!);
                  },
                  decoration: const InputDecoration(labelText: 'Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Do something with the selected options and number value

                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}

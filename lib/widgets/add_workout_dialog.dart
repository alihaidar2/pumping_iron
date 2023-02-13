import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import '../models/workout.dart';
import '../models/workout_plan.dart';

class AddWorkoutDialog extends StatefulWidget {
  final Box<Workout> workoutBox;
  final int workoutPlanId;

  const AddWorkoutDialog({super.key, required this.workoutBox, required this.workoutPlanId});

  @override
  _AddWorkoutDialogState createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _workoutName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      margin: const EdgeInsets.only(top: 66),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Workout Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a workout name';
                }
                return null;
              },
              onSaved: (value) => _workoutName = value!,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.workoutBox.put(Workout(workoutName: _workoutName, workoutPlanId: widget.workoutPlanId, dateTime: DateTime.now()));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

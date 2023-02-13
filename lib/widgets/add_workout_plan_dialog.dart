import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import '../models/workout_plan.dart';

class AddWorkoutPlanDialog extends StatefulWidget {
  final Box<WorkoutPlan> workoutPlanBox;

  AddWorkoutPlanDialog({required this.workoutPlanBox});

  @override
  _AddWorkoutPlanDialogState createState() => _AddWorkoutPlanDialogState();
}

class _AddWorkoutPlanDialogState extends State<AddWorkoutPlanDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _workoutPlanName;

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
                labelText: 'Workout Plan Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a workout plan name';
                }
                return null;
              },
              onSaved: (value) => _workoutPlanName = value!,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.workoutPlanBox
                        .put(WorkoutPlan(workoutPlanName: _workoutPlanName));
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

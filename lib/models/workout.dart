import 'package:objectbox/objectbox.dart';

import 'set.dart';

// @Sync()
@Entity()
class Workout {
  int id;
  final String workoutName;
  final int workoutPlanId;
  final List<Set> sets;
  final DateTime dateTime;

  Workout({
    this.id = 0,
    required this.workoutPlanId,
    required this.workoutName,
    this.sets = const <Set>[],
    required this.dateTime,
  });
}

// Expected workout:
// When you are setting up the Workout, you will chose
// the sets and reps for each one.

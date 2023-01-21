import 'package:objectbox/objectbox.dart';

import 'set.dart';

// @Sync()
@Entity()
class Workout {
  int id;
  final String workoutName;
  final List<Set> sets;
  final DateTime dateTime;

  Workout({
    this.id = 0,
    required this.workoutName,
    this.sets = const <Set>[],
    required this.dateTime,
  });
}


// So a Workout will just be an entry into your Workout Plan
// So your Workout Plan is going to have a Split
// A Split will have list of sets

// Expected workout:
// When you are setting up the Workout, you will chose
// the sets and reps for each one.

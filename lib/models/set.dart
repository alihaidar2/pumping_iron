import 'package:objectbox/objectbox.dart';

import 'exercise.dart';

// @Sync()
@Entity()
class Set {
  int id;
  final String exerciseName; // later will be an exercise
  final int? repetitions;
  final DateTime date;

  Set({
    this.id = 0,
    required this.exerciseName,
    required this.repetitions,
    required this.date,
  });

// final exercise = ToOne<Exercise>();
}


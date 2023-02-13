import 'package:objectbox/objectbox.dart';

@Entity()
class Set {
  int id;
  final int? exerciseId;
  final int? workoutId;
  final int? repetitions;
  final DateTime date;

  Set({
    this.id = 0,
    required this.exerciseId,
    required this.workoutId,
    required this.repetitions,
    required this.date,
  });

// final exercise = ToOne<Exercise>();
}


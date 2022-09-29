import 'package:objectbox/objectbox.dart';

import 'exercise.dart';

// @Sync()
@Entity()
class Set {
  int id;
  final int? repetitions;
  final DateTime date;

  Set({
    this.id = 0,
    required this.repetitions,
    required this.date,
  });

// final exercise = ToOne<Exercise>();
}

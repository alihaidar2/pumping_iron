import 'package:objectbox/objectbox.dart';

import 'exercise.dart';

@Entity()
@Sync()
class Set {
  int id;
  final int? repetitions;

  Set({
    this.id = 0,
    required this.repetitions,
  });

  // final exercise = ToOne<Exercise>();
}

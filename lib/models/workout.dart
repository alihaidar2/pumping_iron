import 'package:objectbox/objectbox.dart';

import 'set.dart';

// @Sync()
@Entity()
class Workout {
  int id;
  final List<Set>? sets;


  Workout({
    this.id = 0,
    this.sets = const <Set>[],
  });
}

import 'package:objectbox/objectbox.dart';
import 'package:pumping_iron/widgets/workout.dart';

import 'set.dart';

// @Sync()
@Entity()
class WorkoutPlan {
  int id;
  final String workoutPlanName;
  final List<WorkoutPlan> workouts;
  final DateTime? dateTime;

  WorkoutPlan({
    this.id = 0,
    required this.workoutPlanName,
    this.workouts = const <WorkoutPlan>[],
    this.dateTime,
  });
}

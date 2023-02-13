import 'package:objectbox/objectbox.dart';
import 'package:pumping_iron/main.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pumping_iron/models/workout.dart';

import '../models/exercise.dart';
import '../models/set.dart';
import '../models/workout_plan.dart';
import '../objectbox.g.dart';
import '../globals.dart' as globals;
import 'api_service.dart';

class ObjectBox {
  // the store/database of the app
  late final Store store;

  late final Box<Set> setBox; // holds all the sets ever --> filter by date
  late final Box<Exercise> exerciseBox; // holds all the sets ever --> filter by date
  late final Box<Workout> workoutBox;
  late final Box<WorkoutPlan> workoutPlanBox;
  // late final Box<Exercise> exerciseBox;

  late final Stream<Query<Set>> setStream;

  ObjectBox._create(this.store) {
    setBox = Box<Set>(store);
    exerciseBox = Box<Exercise>(store);
    workoutBox = Box<Workout>(store);
    workoutPlanBox = Box<WorkoutPlan>(store);
    // exerciseBox = Box<Exercise>(store);

    // final qBuilder = setBox.query();
    // setStream = qBuilder.watch(triggerImmediately: true);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    // Future<store> openStore() {...} is defined in the generated objectbox.g.dart
    // final store = await openStore();
    return ObjectBox._create(store);
  }


  // Set methods
  List<Set> getAllSets() => setBox.getAll();
  void addSet(Set set) => setBox.put(set);

  // Exercise Methods
  List<Exercise> getAllExercises() => exerciseBox.getAll();
  Exercise getExerciseByName(String exerciseName) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.name.equals(exerciseName)).build();
    return query.find().first;
  }
  Exercise getExerciseById(int exerciseId) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.id.equals(exerciseId)).build();
    return query.find().first;
  }
  List<Exercise> getExercisesByTarget(String target) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.target.equals(target)).build();
    return query.find();
  }
  List<Exercise> getExercisesByEquipment(String equipment) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.equipment.equals(equipment)).build();
    return query.find();
  }
  List<Exercise> getExercisesByBodyPart(String bodyPart) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.bodyPart.equals(bodyPart)).build();
    return query.find();
  }

  // Workout methods
  List<Workout> getAllWorkouts() => workoutBox.getAll();
  List<Workout> getWorkoutsByWorkoutPlanId(int id) {
    Query<Workout> query = objectBox.workoutBox.query(
        Workout_.workoutPlanId.equals(id)
    ).build();
    return query.find();
  }
  // List<Workout> getWorkoutsByWorkoutId(int workoutId) {
  //   Query<Exercise> query = workoutBox.query(
  //       Workout_.workoutId.equals(wourkoutId)).build();
  //   return query.find();
  // }
  Workout getWorkoutByName(String name) {
    Query<Workout> query = objectBox.workoutBox.query(
        Workout_.workoutName.equals(name)
    ).build();
    return query.find().first;
  }

  void addWorkout(Workout workout) => workoutBox.put(workout);


  // Workout Plan methods
  List<WorkoutPlan> getAllWorkoutPlans() => workoutPlanBox.getAll();
  void addWorkoutPlan(WorkoutPlan workoutPlan) => workoutPlanBox.put(workoutPlan);
  WorkoutPlan getWorkoutPlanByName(String name) {
    Query<WorkoutPlan> query = objectBox.workoutPlanBox.query(
      WorkoutPlan_.workoutPlanName.equals(name)
    ).build();
    return query.find().first;
  }


  // dev
  void deleteAllSets() => setBox.removeAll();
  void deleteAllExercises() => exerciseBox.removeAll();
  void deleteAllWorkouts() => workoutBox.removeAll();
  void deleteAllWorkoutPlans() => workoutPlanBox.removeAll();

  void deleteEverything() {
    deleteAllExercises();
    deleteAllSets();
    deleteAllWorkouts();
    deleteAllWorkoutPlans();
  }




  // List<Exercise> getExercises() {return exerciseBox.getAll();}

  // Exercise? getExercise(int id) => exerciseBox.get(id);

  // Stream<List<Exercise>> getExercises() => exerciseBox
  //     .query()
  //     .watch(triggerImmediately: true)
  //     .map((event) => event.find());

  // int insertExercise(Exercise exercise) => exerciseBox.put(exercise);

  // bool deleteExercise(int id) => exerciseBox.remove(id);

  // Future<void> updateDatabase() async {
  //   print('Before add: ' + globals.exerciseList.length.toString());
  //   // Get Exercise data
  //   ApiService apiService = ApiService();
  //   List<Exercise> futureExercises = await apiService.get(endpoint: 'exercises');
  //   // Update database and global list
  //   // exerciseBox.removeAll();
  //   exerciseBox.putMany(futureExercises);
  //   globals.exerciseList.removeRange(0, globals.exerciseList.length -1);
  //   globals.exerciseList.addAll(futureExercises);
  //   print('DB after add: ' + objectBox.exerciseBox.getAll().length.toString());
  //   print('Global after add: ' + globals.exerciseList.length.toString());
  // }
}

import 'package:objectbox/objectbox.dart';
import 'package:pumping_iron/main.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pumping_iron/models/workout.dart';

import '../models/exercise.dart';
import '../models/set.dart';
import '../objectbox.g.dart';
import '../globals.dart' as globals;
import 'api_service.dart';

class ObjectBox {
  // the store/database of the app
  late final Store store;

  late final Box<Set> setBox; // holds all the sets ever --> filter by date
  late final Box<Exercise> exerciseBox; // holds all the sets ever --> filter by date
  late final Box<Workout> workoutBox;
  // late final Box<Exercise> exerciseBox;

  late final Stream<Query<Set>> setStream;

  ObjectBox._create(this.store) {
    setBox = Box<Set>(store);
    exerciseBox = Box<Exercise>(store);
    workoutBox = Box<Workout>(store);
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

  List<Set> getSets() {
    return setBox.getAll();
  }

  List<Exercise> getAllExercises() {
    return exerciseBox.getAll();
  }

  List<Exercise> getExercisesByTarget(String newValue) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.target.equals(newValue)).build();
    return query.find();
  }

  Exercise getExerciseByName(String exerciseName) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.name.equals(exerciseName)).build();
    return query.find().first;
  }

  Exercise getExerciseById(int? exerciseId) {
    Query<Exercise> query = objectBox.exerciseBox.query(Exercise_.id.equals(exerciseId!)).build();
    return query.find().first;
    // barbell bench press, barbell incline bench press
    // pull-up, alternate lateral pulldown
    // barbell full zercher squat, barbell front squat
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

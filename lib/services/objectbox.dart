import '../models/exercise.dart';
import '../models/set.dart';
import '../objectbox.g.dart';

class ObjectBox {
  // the store/database of the app
  late final Store store;

  late final Box<Set> setBox;
  late final Box<Exercise> exerciseBox;

  late final Stream<Query<Set>> setStream;

  ObjectBox._create(this.store) {
    setBox = Box<Set>(store);
    exerciseBox = Box<Exercise>(store);

    final qBuilder = setBox.query();
    setStream = qBuilder.watch(triggerImmediately: true);
  }

  static Future<ObjectBox> create() async {
    // Future<store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }

  List<Exercise> getExercises() {
    return exerciseBox.getAll();
  }



}
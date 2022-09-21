library pump_that_iron.globals;

import 'models/exercise.dart';

List<Exercise> exerciseList2 = List<Exercise>.generate(3, (int index) => new Exercise(
    name: "name"+index.toString(),
    target: "target"+index.toString(),
    bodyPart: "bodyPart"+index.toString(),
    equipment: "equipment"+index.toString(),
    gifUrl: "gifUrl"+index.toString()),
    growable: true);

List<Exercise> exerciseList = List.empty(growable: true);

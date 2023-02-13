import '../main.dart';
import '../models/exercise.dart';

class Utils {
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // idk if I ned this anymore
  static List<Exercise>? getExercisesFromSelection(String target) {
    switch (target) {
      case "chest":
        return objectBox.getExercisesByTarget('pectorals');
      case "back":
        List<Exercise> exercises = [];
        exercises.addAll(objectBox.getExercisesByBodyPart('back'));
        exercises.addAll(objectBox.getExercisesByBodyPart('neck'));
        return exercises;
      case "shoulders":
        return objectBox.getExercisesByBodyPart('shoulders');
      case "legs":
        List<Exercise> exercises = [];
        exercises.addAll(objectBox.getExercisesByBodyPart('lower legs'));
        exercises.addAll(objectBox.getExercisesByBodyPart('upper legs'));
        return exercises;
      case "biceps":
        return objectBox.getExercisesByTarget('biceps');
      case "triceps":
        return objectBox.getExercisesByTarget('triceps');
      default:
        return null;
    }
  }


  static int getAge(DateTime birthDate, DateTime currentDate) {
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}

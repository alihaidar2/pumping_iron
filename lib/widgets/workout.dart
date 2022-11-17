import 'package:flutter/widgets.dart';
import '../main.dart';
import '../models/set.dart';
import '../objectbox.g.dart';


class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late List<Set> sets;
  late DateTime dateTime;


  @override
  Widget build(BuildContext context) {

    Query<Set> query = objectBox.setBox.query().build();

    // PropertyQuery<String> query2 = objectBox.setBox
    //     .query().build()
    //     .property(Set_.date);
    // query.distinct = true;
    // List<String> exerciseNames = query.find();

    return Container();
  }

  //

}

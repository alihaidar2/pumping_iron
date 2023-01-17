import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:pumping_iron/pages/test_page.dart';
import 'package:pumping_iron/pages/workout_page.dart';
import '../main.dart';
import '../models/set.dart';
import 'package:flutter/material.dart';

import '../objectbox.g.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late String title;
  late List<Set> sets;
  late List<Set> sets1;
  late List<Set> sets2;
  late List<Set> sets3;
  late List<List<Set>> setDates;
  late List<String> days;
  late var dates;

  @override
  void initState() {
    super.initState();
    title = "Workout Dates";
    sets = objectBox.setBox.query().build().find().toList();

    // get a list of all dates, grouped by day
    dates = groupSetsByDate(sets);
  }

  @override
  Widget build(BuildContext context) {
    // ListView of setDates
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            var date = dates.elementAt(index);
            return ListTile(
              title: Text(cleanDate(date)),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              //onTap calls When ListTile Taps
              onTap: () {
                // Navigator pushes Workout for that date.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutPage(title: title, year: date.year, month: date.month, day: date.day),
                  ),
                );
              },
            );
          }),
    );

    return Container();
  }

  Iterable<DateTime> groupSetsByDate(List<Set> sets) {
    final dates = groupBy(sets, (Set s) {
      // this needs to group by day month and year not just date
      // I'll just have to reform the date

      // create date from sd.date.day
      return s.date;
    });

    return dates.keys;
  }

  String cleanDate(DateTime date) {
    return date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
  }

}

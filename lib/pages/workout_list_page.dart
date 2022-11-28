import 'package:flutter/widgets.dart';
import '../main.dart';
import '../models/set.dart';
import 'package:flutter/material.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late List<Set> sets;
  late List<Set> sets1;
  late List<Set> sets2;
  late List<Set> sets3;
  late List<List<Set>> setDates;

  @override
  void initState() {
    super.initState();
    sets = objectBox.setBox.getAll();

    sets1 = sets
        .where((element) => element.date.month == 11)
        .where((element) => element.date.day == 1)
        .toList();
    sets2 = sets
        .where((element) => element.date.month == 11)
        .where((element) => element.date.day == 16)
        .toList();
    sets3 = sets
        .where((element) => element.date.month == 11)
        .where((element) => element.date.day == 22)
        .toList();

    setDates = [sets1, sets2, sets3];

    print('');
  }

  @override
  Widget build(BuildContext context) {
    // ListView of setDates
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Dates'),
      ),
      body: ListView.builder(
        itemCount: setDates.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                print(setDates.elementAt(index).elementAt(0).date.day.toString()+"/"
                  +setDates.elementAt(index).elementAt(0).date.month.toString());

                // TODO: Navigate to a new page with the sets for that date
                // Navigator.pushNamed(context, '/workout',
                //     arguments: setDates.elementAt(index));
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Date: ${setDates[index][0].date.day}/${setDates[index][0].date.month}"),
              ),
            ),
          );
          return ListTile(
              title: Text("Date: ${setDates[index][0].date.day}"),);
        },
      ),
    );

    return Container();
  }
}

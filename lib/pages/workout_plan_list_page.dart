import 'package:flutter/material.dart';
import 'package:pumping_iron/main.dart';
import 'package:pumping_iron/models/workout_plan.dart';
import 'package:pumping_iron/pages/workout_list_page.dart';

class WorkoutPlanListPage extends StatefulWidget {
  const WorkoutPlanListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPlanListPage> createState() => _WorkoutPlanListPageState();
}

class _WorkoutPlanListPageState extends State<WorkoutPlanListPage> {
  @override
  Widget build(BuildContext context) {
    List<WorkoutPlan> workoutPlans = objectBox.getAllWorkoutPlans();

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Plan List Page"),
      ),
      body: ListView.builder(itemCount: workoutPlans.length, itemBuilder: (context, index) {
        return Container(
          height: 50,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutListPage(workoutPlanId: workoutPlans.elementAt(index).id,),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: new Text(workoutPlans.elementAt(index).workoutPlanName,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}

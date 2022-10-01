import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class ExerciseEntry extends StatelessWidget {
  // String? name;
  // String? target;
  // String? gifUrl;

  // ExerciseEntry(this.name, this.target, this.gifUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Flexible(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start, // for left side
                children: [
                  Text(
                    "Bench Press",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  VerticalDivider(
                    width: 50.0,
                  ),
                  Expanded(
                      child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Text("Set $index :  ${index + 7} rep(s)");
                        }),
                  )),
                ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ListView.builder(
//   shrinkWrap: true,
//   itemCount: 4,
//   itemBuilder: (context, index) {
//     return ListTile(
//       title: Text("Set ${index+1}"),
//       subtitle: Text("Reps : ${index+7}"),
//
//     );
//   },
// ),

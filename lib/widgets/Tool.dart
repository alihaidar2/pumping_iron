// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class Tool extends StatelessWidget {
  String functionName;
  Icon icon;

  Tool(this.functionName, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,15,0),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // for left side
                children: [
                  Text(
                    "widget.name!.toTitleCase()",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  Text("target!.toTitleCase()", textAlign: TextAlign.left),
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

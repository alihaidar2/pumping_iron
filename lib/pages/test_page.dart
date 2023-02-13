import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pumping_iron/widgets/ExerciseEntry.dart';
// import 'package:pump_that_iron/models/set.dart' as sett;
// import 'package:pump_that_iron/globals.dart' as globals;

import '../main.dart';
import '../models/exercise.dart';
import '../models/set.dart';
import '../globals.dart' as globals;
import '../objectbox.g.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<Set> sets;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Text("TESSSSSSST");
  }
}

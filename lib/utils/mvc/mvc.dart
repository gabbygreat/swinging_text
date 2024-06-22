import 'package:flutter/material.dart';

///1. copy controller and view to a new view folder
///2. Find and replace Mvc with the name of the view
///3. Resolve all imports and you're good to go

abstract class StatelessView<T1, T2> extends StatelessWidget {
  final T2 controller;
  T1 get widget => (controller as State).widget as T1;
  const StatelessView(this.controller, {super.key});
  @override
  Widget build(BuildContext context);
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String Weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.Weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(
          exerciseName,
        ),
        subtitle: Row(
          children: [
            Chip(
                label: Text(
              "${Weight}kg",
            )),
            Chip(
                label: Text(
              "${reps}reps",
            )),
            Chip(
                label: Text(
              "${sets}sets",
            ))
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workout/Models/exercise.dart';
import 'package:workout/Models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
      name: "upperbody",
      exercises: [
        exercise(
          name: "bicep curls",
          weight: "10",
          reps: "10",
          sets: "3",
        ),
      ],
    ),
    Workout(
      name: "lowerbody",
      exercises: [
        exercise(
          name: "Squats",
          weight: "10",
          reps: "10",
          sets: "3",
        ),
      ],
    )
  ];

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout releventWorkout = getRelevantWorkout(workoutName);

    releventWorkout.exercises.add(
      exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    exercise relevantExercise = getReleventExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((Workout) => Workout.name == workoutName);

    return relevantWorkout;
  }

  exercise getReleventExercise(String workoutName, String exerciseName) {
    Workout releventWorkout = getRelevantWorkout(workoutName);
    exercise releventExercise = releventWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return releventExercise;
  }
}

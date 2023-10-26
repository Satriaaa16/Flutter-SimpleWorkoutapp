import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/components/exercise_tile.dart';
import 'package:workout/data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  final newWorkoutNameController = TextEditingController();
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("create new Workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ),
        ],
      ),
    );
  }

  void save() {
    // ignore: unused_local_variable
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;

    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weight,
      reps,
      sets,
    );

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('add New Exercise'),
        content: Column(
          children: [
            TextField(
              controller: exerciseNameController,
            ),
            TextField(
              controller: weightController,
            ),
            TextField(
              controller: repsController,
            ),
            TextField(
              controller: setsController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(title: Text(widget.workoutName)),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            Weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckBoxChanged: (val) {
              onCheckBoxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name,
              );
            },
          ),
        ),
      ),
    );
  }
}

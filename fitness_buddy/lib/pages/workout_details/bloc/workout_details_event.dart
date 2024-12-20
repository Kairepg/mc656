part of 'workout_details_bloc.dart';

@immutable
abstract class WorkoutDetailsEvent {}

class BackTappedEvent extends WorkoutDetailsEvent {}

class WorkoutExerciseCellTappedEvent extends WorkoutDetailsEvent {
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  WorkoutExerciseCellTappedEvent({
    required this.currentExercise,
    required this.nextExercise,
  });
}

class StartTappedEvent extends WorkoutDetailsEvent {
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  StartTappedEvent({
    required this.currentExercise,
    required this.nextExercise,
  });
}

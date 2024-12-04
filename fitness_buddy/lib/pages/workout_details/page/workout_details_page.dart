import 'package:fitness_buddy/utils/text_constants.dart';
import 'package:fitness_buddy/data/exercise_data.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/pages/start_workout/page/start_workout_page.dart';
import 'package:fitness_buddy/pages/workout_details/bloc/workout_details_bloc.dart';
import 'package:fitness_buddy/pages/workout_details/widget/workout_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_buddy/utils/list_extension.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutDetailsPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<WorkoutDetailsBloc> _buildContext(BuildContext context) {
  return BlocProvider<WorkoutDetailsBloc>(
    create: (context) => WorkoutDetailsBloc(workout: workout),
    child: BlocConsumer<WorkoutDetailsBloc, WorkoutDetailsState>(
      buildWhen: (_, currState) => currState is WorkoutDetailsInitial,
      builder: _buildWorkoutDetails,
      listenWhen: (_, currState) =>
          currState is BackTappedState || currState is WorkoutExerciseCellTappedState,
      listener: _handleStateChanges,
    ),
  );
}

Widget _buildWorkoutDetails(BuildContext context, WorkoutDetailsState state) {
  return Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: _buildFloatingActionButton(context),
    body: WorkoutDetailsContent(workout: workout),
  );
}

Widget _buildFloatingActionButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: FitnessButton(
      title: TextConstants.start,
      onTap: () => _navigateToStartWorkout(context),
    ),
  );
}

void _navigateToStartWorkout(BuildContext context) {
  ExerciseData? exercise = workout.exerciseDataList!.firstWhereOrNull(
    (element) => element.progress! < 1,
  );
  exercise ??= workout.exerciseDataList!.first;
  int exerciseIndex = workout.exerciseDataList!.indexOf(exercise);

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<WorkoutDetailsBloc>(context),
        child: StartWorkoutPage(
          workout: workout,
          exercise: exercise!,
          currentExercise: exercise,
          nextExercise: exerciseIndex + 1 < workout.exerciseDataList!.length
              ? workout.exerciseDataList![exerciseIndex + 1]
              : null,
        ),
      ),
    ),
  );
}

void _handleStateChanges(BuildContext context, WorkoutDetailsState state) {
  if (state is BackTappedState) {
    Navigator.pop(context);
  } else if (state is WorkoutExerciseCellTappedState) {
    _navigateToWorkoutExercise(context, state);
  }
}

void _navigateToWorkoutExercise(BuildContext context, WorkoutExerciseCellTappedState state) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<WorkoutDetailsBloc>(context),
        child: StartWorkoutPage(
          workout: workout,
          exercise: state.currentExercise,
          currentExercise: state.currentExercise,
          nextExercise: state.nextExercise,
        ),
      ),
    ),
  );
}

}
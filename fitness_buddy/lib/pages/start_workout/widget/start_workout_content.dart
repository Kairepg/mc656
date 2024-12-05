import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/services/data_service.dart';
import 'package:fitness_buddy/utils/color_constants.dart';
import 'package:fitness_buddy/utils/path_constants.dart';
import 'package:fitness_buddy/utils/text_constants.dart';
import 'package:fitness_buddy/data/exercise_data.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/pages/start_workout/bloc/start_workout_bloc.dart';
import 'package:fitness_buddy/pages/start_workout/page/start_workout_page.dart';
import 'package:fitness_buddy/pages/start_workout/widget/start_workout_video.dart';
import 'package:fitness_buddy/pages/workout_details/bloc/workout_details_bloc.dart' as workout_bloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartWorkoutContent extends StatelessWidget {
  final WorkoutData workout;
  final ExerciseData exercise;
  final ExerciseData? nextExercise;

  const StartWorkoutContent({super.key, required this.workout ,required this.exercise, required this.nextExercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: SafeArea(
        child: _createDetailedExercise(context),
      ),
    );
  }

  Widget _createDetailedExercise(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createBackButton(context),
          const SizedBox(height: 23),
          _createVideo(context),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(children: [
              _createTitle(),
              const SizedBox(height: 9),
              _createDescription(),
              const SizedBox(height: 30),
              _createSteps(),
            ]),
          ),
          _createTimeTracker(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<StartWorkoutBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8),
      child: GestureDetector(
        child: BlocBuilder<StartWorkoutBloc, StartWorkoutState>(
          builder: (context, state) {
            return const Row(
              children: [
                Image(image: AssetImage(PathConstants.back)),
                SizedBox(width: 17),
                Text(
                  TextConstants.back,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ),
        onTap: () {
          bloc.add(BackTappedEvent());
        },
      ),
    );
  }

  Widget _createVideo(BuildContext context) {
    final bloc = BlocProvider.of<StartWorkoutBloc>(context);
    return Container(
      height: 264,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorConstants.white),
      child: StartWorkoutVideo(
        exercise: exercise,
        onPlayTapped: (time) {
          bloc.add(PlayTappedEvent(time: time));
        },
        onPauseTapped: (time) {
          bloc.add(PauseTappedEvent(time: time));
        },
      ),
    );
  }

  Widget _createTitle() {
    return Text(exercise.title!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  Widget _createDescription() {
    return Text(exercise.description!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
  }

  Widget _createSteps() {
    return Column(
      children: [
        for (int i = 0; i < exercise.steps!.length; i++) ...[
          Step(number: "${i + 1}", description: exercise.steps![i]),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _createTimeTracker(BuildContext context) {
    // final bloc = BlocProvider.of<StartWorkoutBloc>(context);
    return Container(
      width: double.infinity,
      color: ColorConstants.white,
      child: Column(
        children: [
          nextExercise != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      TextConstants.nextExercise,
                      style: TextStyle(
                        color: ColorConstants.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      nextExercise?.title ?? "",
                      style: const TextStyle(
                        color: ColorConstants.textBlack,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6.5),
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 6.5),
                    Text('${nextExercise!.minutes! > 9 ? nextExercise!.minutes : '0${nextExercise!.minutes}'}:00 minutes')
                    // BlocBuilder<StartWorkoutBloc, StartWorkoutState>(
                    //   buildWhen: (_, currState) => currState is PlayTimerState || currState is PauseTimerState,
                    //   builder: (context, state) {
                    //     return StartWorkoutTimer(
                    //       time: bloc.time,
                    //       isPaused: !(state is PlayTimerState),
                    //     );
                    //   },
                    // ),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 18),
          _createButton(context),
        ],
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return FitnessButton(
      title: nextExercise != null ? TextConstants.next : 'Finish',
      onTap: () async {
        if (nextExercise != null) {
          List<ExerciseData> exercisesList = BlocProvider.of<workout_bloc.WorkoutDetailsBloc>(context).workout.exerciseDataList!;
          int currentExerciseIndex = exercisesList.indexOf(exercise);
          await _saveWorkout(currentExerciseIndex);
          if (currentExerciseIndex < exercisesList.length - 1) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<workout_bloc.WorkoutDetailsBloc>(context),
                        child: StartWorkoutPage(
                          workout: workout,
                          exercise: exercisesList[currentExerciseIndex + 1],
                          currentExercise: exercisesList[currentExerciseIndex + 1],
                          nextExercise: currentExerciseIndex + 2 < exercisesList.length ? exercisesList[currentExerciseIndex + 2] : null,
                        ),
                      )),
            );
          } 
        } else {
          await _saveWorkout(workout.exerciseDataList!.length - 1);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future<void> _saveWorkout(int exerciseIndex) async {
    if (workout.currentProgress! < exerciseIndex + 1) {
      workout.currentProgress = exerciseIndex + 1;
    }
    workout.exerciseDataList![exerciseIndex].progress = 1;

    await DataService.saveWorkout(workout);
  }
}
  

class Step extends StatelessWidget {
  final String number;
  final String description;

  const Step({super.key, required this.number, required this.description});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.primaryColor.withOpacity(0.12),
          ),
          child: Center(child: Text(number, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorConstants.primaryColor))),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(description)),
      ],
    );
  }
}
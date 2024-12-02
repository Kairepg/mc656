import 'package:fitness_buddy/utils/color_constants.dart';
import 'package:fitness_buddy/utils/text_constants.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/pages/workouts/bloc/workout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutCard({super.key, required this.workout});
   @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutsBloc>(context);
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          )
        ],
      ),
       child: Material(
        color: Colors.transparent,
        child: BlocBuilder<WorkoutsBloc, WorkoutsState>(
          buildWhen: (_, currState) => currState is CardTappedState,
          builder: (context, state) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                bloc.add(CardTappedEvent(workout: workout));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(workout.title ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3),
                          Text(
                              '${workout.exerciseDataList!.length} ${TextConstants.exercisesUppercase}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          const SizedBox(height: 3),
                          Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              '${_getWorkoutMinutes()}' " " +
                                  TextConstants.minutes,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          const Spacer(),
                          Text('${workout.currentProgress}/${workout.progress}',
                              style: const TextStyle(fontSize: 10)),
                          const SizedBox(height: 3),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, left: 2),
                            child: LinearPercentIndicator(
                              percent:
                                  workout.currentProgress! / workout.progress!,
                              progressColor: ColorConstants.primaryColor,
                              backgroundColor:
                                  ColorConstants.primaryColor.withOpacity(0.12),
                              lineHeight: 6,
                              padding: EdgeInsets.zero,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:
                            Image.asset(workout.image ?? "", fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  int _getWorkoutMinutes() {
    var minutes = 0;
    final minutesList =
        workout.exerciseDataList!.map((e) => e.minutes).toList();
    for (var e in minutesList) {
      minutes += e!;
    }
    return minutes;
  }
}
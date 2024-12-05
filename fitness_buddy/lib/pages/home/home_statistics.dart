
import 'package:fitness_buddy/data/exercise_data.dart';
import 'package:fitness_buddy/pages/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness_buddy/data/workout_data.dart';




class HomeStatistics extends StatelessWidget {
  final List<WorkoutData>? userWorkouts;
  const HomeStatistics({
    required this.userWorkouts,
    super.key});

  
   int? getFinishedWorkouts() {
    final completedWorkouts =
        userWorkouts?.where((w) => w.currentProgress == w.progress).toList();
    return completedWorkouts?.length;
    }

   int? getInProgressWorkouts() {
    final completedWorkouts = userWorkouts?.where(
        (w) => (w.currentProgress ?? 0) > 0 && w.currentProgress != w.progress);
    return completedWorkouts?.length;
   }

    int? getTimeSpent() {
      int tempo = 0;
      List<ExerciseData> exercises = <ExerciseData>[];
      for (final WorkoutData workout in userWorkouts!) {
        exercises.addAll(workout.exerciseDataList!);
      }
      final exercise = exercises.where((e) => e.progress == 1).toList();
      for (var e in exercise) {
        tempo += e.minutes!;
      }
      return tempo;
    }

  Widget _createOtherData(context){
    return Column(
      children: [
        ExtraInfoButton(text: "Em progresso", num: getInProgressWorkouts().toString(), type: "Treinos"),
        const SizedBox(height: 10),
        ExtraInfoButton(text: "Tempo Gasto", num: getTimeSpent().toString(), type: "Minutos")
      ],
    );
  }


   Widget _createFinished(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            children: [
              
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Finalizados",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ],
          ),
          Text(
            '${getFinishedWorkouts()}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Text(
            "Treinos completos",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createFinished(context),
          _createOtherData(context),
        ],
      ),
    );
  }
}
import 'package:fitness_buddy/pages/home/home_statistics.dart';
import 'package:fitness_buddy/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/routes/routes.dart';


class HomeContent extends StatelessWidget {
   final List<WorkoutData> workouts;

  const HomeContent({
    required this.workouts,
    super.key,
  });
  

  Widget _createStartWorkout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 1.1,
          )
        ],
      ),
      child: Column(
        children: [
         
          const SizedBox(height: 16),
          const Text("Comece a se exercitar!!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text("Seja como Gabriel Viterbo",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
          const SizedBox(height: 24),
          FitnessButton(
            title: "Workouts",
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.workouts);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<HomeBloc>(context);
    return FutureBuilder(future: DataService.getUserWorkouts(), builder: 
    (BuildContext context, AsyncSnapshot<List<WorkoutData>> snapshot) {
    final workoutsL = snapshot.data;
    Widget homeInfo;
    if (workoutsL!.isNotEmpty){
        homeInfo = HomeStatistics(userWorkouts: workoutsL);
    } else{
      homeInfo = _createStartWorkout(context);
    }
    if(snapshot.hasData){
    
    return
    SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const SizedBox(height: 35),
          homeInfo,
        ],
      )
    );
    }else {
      return const Text("Loading");

    }

  });
  }
}

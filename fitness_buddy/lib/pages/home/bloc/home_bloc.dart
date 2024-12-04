import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/services/data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_buddy/data/exercise_data.dart';
// import 'package:fitness_buddy/pages/home/bloc/home_event.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) 
  {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    // mapEventToState;
  }

  List<WorkoutData> workouts = <WorkoutData>[];
  List<ExerciseData> exercises = <ExerciseData>[];
  int timeSent = 0;


  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }


  // @override
  // Stream<HomeState> mapEventToState(
  //   HomeEvent event,
  // ) async* {
  //   if (event is HomeInitialEvent) {
  //     workouts  = await DataService.getUserWorkouts();
  //     yield WorkoutsGotState(workouts: workouts);
  //   }
  // }

}







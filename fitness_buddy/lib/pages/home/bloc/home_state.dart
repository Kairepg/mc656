part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class WorkoutsGotState extends HomeState {
  final List<WorkoutData> workouts;

  WorkoutsGotState({
    required this.workouts,
  });
}
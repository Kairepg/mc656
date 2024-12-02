import 'package:bloc/bloc.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workout_details_event.dart';
part 'workout_details_state.dart';

class WorkoutDetailsBloc
    extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  late WorkoutData workout;

  WorkoutDetailsBloc() : super(WorkoutDetailsInitial()) {
    on<WorkoutDetailsInitialEvent>(_onWorkoutDetailsInitialEvent);
    on<BackTappedEvent>(_onBackTappedEvent);
    on<StartTappedEvent>(_onStartTappedEvent);
  }

  void _onWorkoutDetailsInitialEvent(
      WorkoutDetailsInitialEvent event, Emitter<WorkoutDetailsState> emit) {
    workout = event.workout;
    emit(ReloadWorkoutDetailsState(workout: workout));
  }

  void _onBackTappedEvent(
      BackTappedEvent event, Emitter<WorkoutDetailsState> emit) {
    emit(BackTappedState());
  }

  void _onStartTappedEvent(
      StartTappedEvent event, Emitter<WorkoutDetailsState> emit) {
    emit(StartTappedState(
      workout: event.workout ?? workout,
      index: event.index ?? 0,
      isReplace: event.isReplace,
    ));
  }
}

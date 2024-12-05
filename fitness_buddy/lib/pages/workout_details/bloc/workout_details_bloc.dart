import 'package:bloc/bloc.dart';
import 'package:fitness_buddy/data/exercise_data.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workout_details_event.dart';
part 'workout_details_state.dart';

class WorkoutDetailsBloc extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  final WorkoutData workout;

  WorkoutDetailsBloc({required this.workout}) : super(WorkoutDetailsInitial()) {
    // Event handler for BackTappedEvent
    on<BackTappedEvent>(_onBackTapped);

    // Event handler for WorkoutExerciseCellTappedEvent
    on<WorkoutExerciseCellTappedEvent>(_onWorkoutExerciseCellTapped);
    on<StartTappedEvent>(_onStartedTapped);
  }

  void _onBackTapped(
    BackTappedEvent event,
    Emitter<WorkoutDetailsState> emit,
  ) {
    emit(BackTappedState());
  }

  void _onWorkoutExerciseCellTapped(
    WorkoutExerciseCellTappedEvent event,
    Emitter<WorkoutDetailsState> emit,
  ) {
    emit(WorkoutExerciseCellTappedState(
      currentExercise: event.currentExercise,
      nextExercise: event.nextExercise,
    ));
  }


  void _onStartedTapped(
    StartTappedEvent event,
    Emitter<WorkoutDetailsState> emit,
  ) {
    emit(StartTappedState(
      currentExercise: event.currentExercise,
      nextExercise: event.nextExercise,
    ));
  }
}

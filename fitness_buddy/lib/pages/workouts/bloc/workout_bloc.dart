import 'dart:async';
import 'package:fitness_buddy/services/data_service.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:fitness_buddy/utils/data_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fitness_buddy/data/workout_data.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial()) {
    on<WorkoutsInitialEvent>(_onWorkoutsInitialEvent);
    on<CardTappedEvent>(_onCardTappedEvent);
  }

  List<WorkoutData> workouts = DataConstants.workouts;

  Future<void> _onWorkoutsInitialEvent(
      WorkoutsInitialEvent event, Emitter<WorkoutsState> emit) async {
    try {
      GlobalConstants.workouts = await DataService.getWorkoutsForUser();
      for (int i = 0; i < workouts.length; i++) {
        final workoutsUserIndex =
            GlobalConstants.workouts.indexWhere((w) => w.id == workouts[i].id);
        if (workoutsUserIndex != -1) {
          workouts[i] = GlobalConstants.workouts[workoutsUserIndex];
        }
      }
      emit(ReloadWorkoutsState(workouts: workouts));
    } catch (e) {
      // Emita um estado de erro se necessário
      emit(WorkoutsInitial());
    }
  }

  void _onCardTappedEvent(
      CardTappedEvent event, Emitter<WorkoutsState> emit) {
    emit(CardTappedState(workout: event.workout));
  }
}

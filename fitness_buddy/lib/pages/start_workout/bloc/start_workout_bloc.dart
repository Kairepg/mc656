import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_workout_event.dart';
part 'start_workout_state.dart';

class StartWorkoutBloc extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  int time = 0;
  Timer? _timer;

  StartWorkoutBloc() : super(StartWorkoutInitial()) {
    on<BackTappedEvent>(_onBackTappedEvent);
    on<PlayTappedEvent>(_onPlayTappedEvent);
    on<PauseTappedEvent>(_onPauseTappedEvent);
    on<ChangeTimerEvent>(_onChangeTimerEvent);
  }

  // Event Handlers
  void _onBackTappedEvent(
      BackTappedEvent event, Emitter<StartWorkoutState> emit) {
    _cancelTimer();
    emit(BackTappedState());
  }

  void _onPlayTappedEvent(
      PlayTappedEvent event, Emitter<StartWorkoutState> emit) {
    _startTimer(event.time, emit);
    emit(PlayTimerState(time: time));
  }

  void _onPauseTappedEvent(
      PauseTappedEvent event, Emitter<StartWorkoutState> emit) {
    _cancelTimer();
    emit(PauseTimerState(currentTime: time));
  }

  void _onChangeTimerEvent(
      ChangeTimerEvent event, Emitter<StartWorkoutState> emit) {
    emit(PlayTimerState(time: time));
  }

  // Timer Management
  void _startTimer(int initialTime, Emitter<StartWorkoutState> emit) {
    _cancelTimer(); // Cancela qualquer temporizador existente
    time = initialTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        time -= 1;
        add(ChangeTimerEvent());
      } else {
        _cancelTimer();
        emit(StartWorkoutInitial()); // Reinicia para o estado inicial quando o tempo acaba
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _cancelTimer(); // Garante o cancelamento do temporizador ao fechar o BLoC
    return super.close();
  }
}

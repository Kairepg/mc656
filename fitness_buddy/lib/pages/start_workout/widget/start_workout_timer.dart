import 'package:custom_timer/custom_timer.dart';
import 'package:fitness_buddy/services/date_service.dart';
import 'package:flutter/material.dart';

class StartWorkoutTimer extends StatefulWidget {
  final int time;
  final bool isPaused;

  const StartWorkoutTimer({super.key, 
    required this.time,
    required this.isPaused,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StartWorkoutTimerState createState() => _StartWorkoutTimerState();
}

class _StartWorkoutTimerState extends State<StartWorkoutTimer>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTimerController(
      vsync: this, // Necessário para animações
      begin: Duration(seconds: widget.time),
      end: const Duration(seconds: 0),
    );

    // Se o timer não estiver pausado, inicia automaticamente
    if (!widget.isPaused) {
      _controller.start();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos do controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPaused ? _createPauseText() : _createCountdownTimer();
  }

  Widget _createCountdownTimer() {
    return CustomTimer(
      controller: _controller,
      builder: (CustomTimerState state, CustomTimerRemainingTime remaining) {
      return Text(
        "${remaining.minutes}:${remaining.seconds}",
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      );
    },
    );
  }

  Widget _createPauseText() {
    final minutesSeconds = DateService.convertIntoSeconds(widget.time);
    return Text(
      "${minutesSeconds.minutes.toString().padLeft(2, '0')}:${minutesSeconds.seconds.toString().padLeft(2, '0')}",
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

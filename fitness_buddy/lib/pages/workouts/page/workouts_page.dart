import 'package:flutter/material.dart';
import 'package:fitness_buddy/pages/workouts/bloc/workout_bloc.dart';
import 'package:fitness_buddy/pages/workouts/widget/workout_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<WorkoutsBloc> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutsBloc>(
      create: (context) => WorkoutsBloc(),
      child: BlocConsumer<WorkoutsBloc, WorkoutsState>(
        buildWhen: (_, currState) => currState is WorkoutsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<WorkoutsBloc>(context);
          bloc.add(WorkoutsInitialEvent());
          return const WorkoutContent();
        },
        listenWhen: (_, currState) => currState is CardTappedState,
        listener: (context, state) async {
          if (state is CardTappedState) {
            // await Navigator.of(context, rootNavigator: true).push(
            //   MaterialPageRoute(
            //     builder: (_) => WorkoutDetailsPage(workout: state.workout),
            //   ),
            // );
            final bloc = BlocProvider.of<WorkoutsBloc>(context);
            bloc.add(WorkoutsInitialEvent());
          }
        },
      ),
    );
  }
}
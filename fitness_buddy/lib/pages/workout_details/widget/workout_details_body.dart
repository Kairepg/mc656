import 'package:fitness_buddy/utils/color_constants.dart';
import 'package:fitness_buddy/utils/path_constants.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:fitness_buddy/pages/workout_details/bloc/workout_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutDetailsBody extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutDetailsBody({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutDetailsBloc>(context);
    return Positioned(
      left: 20,
      top: 14,
      child: SafeArea(
        child: BlocBuilder<WorkoutDetailsBloc, WorkoutDetailsState>(
          builder: (context, state) {
            return GestureDetector(
              child: const SizedBox(
                width: 30,
                height: 30,
                child: Image(
                  image: AssetImage(PathConstants.back),
                ),
              ),
              onTap: () {
                bloc.add(BackTappedEvent());
              },
            );
          },
        ),
      ),
    );
  }


  Widget _createImage() {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: AssetImage(workout.image ?? ""),
        fit: BoxFit.cover,
      ),
    );
  }
}
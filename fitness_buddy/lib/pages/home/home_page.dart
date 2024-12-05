import 'package:fitness_buddy/pages/home/bloc/home_bloc.dart';
import 'package:fitness_buddy/pages/home/home_content.dart';
import 'package:fitness_buddy/services/permissions.dart';
import 'package:fitness_buddy/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:fitness_buddy/data/workout_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<WorkoutData> workouts;

  @override
  void initState() {
    super.initState();
    PushNotificationService pushNotificationService = PushNotificationService();
    PermissionsMethods().askNotificationPermission();
    pushNotificationService.getFirebaseToken();
    pushNotificationService.startListeningForNewNotification(context);
    // workouts = await DataService.getWorkoutsForUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<HomeBloc> _buildContext(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (_, currState) =>
            currState is HomeInitial || currState is WorkoutsGotState,
        builder: (context, state) {
          final bloc = BlocProvider.of<HomeBloc>(context);
          if (state is HomeInitial) {
            bloc.add(HomeInitialEvent());
            // bloc.add(ReloadDisplayNameEvent());
            // bloc.add(ReloadImageEvent());
          }
          return HomeContent(workouts: bloc.workouts);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

}
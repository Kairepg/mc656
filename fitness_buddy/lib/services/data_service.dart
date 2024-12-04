import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:fitness_buddy/data/workout_data.dart';

class DataService {
  
static Future<List<WorkoutData>> getUserWorkouts() async {
  final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final workoutsDoc = FirebaseFirestore.instance.collection('workouts');
    try {
      DocumentSnapshot snapshot = await workoutsDoc.doc(user?.email).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> workoutList = data['exerciseDataList'];
        final workouts = workoutList.map((e) {
          final decodedE = json.decode(e) as Map<String, dynamic>?;
          return WorkoutData.fromJson(decodedE!);
        }).toList();
        return workouts;
      } else {
        return [];  // documento nao existe
      }
    } catch (e) {
      return []; // erro
    }


  }


  static Future<void> saveWorkout(WorkoutData workout) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    FirebaseFirestore workouts;
    workouts = FirebaseFirestore.instance;
    bool newDoc = false;
    
    final allWorkouts = await getUserWorkouts();
    if (allWorkouts.isEmpty){
      newDoc = true;
    }
    final index = allWorkouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      allWorkouts[index] = workout;
    } else {
      allWorkouts.add(workout);
    }
    GlobalConstants.workouts = allWorkouts;
    final workoutsSave = allWorkouts.map((e) => e.toJsonString()).toList();
    if (newDoc && user != null) {
        await FirebaseFirestore.instance
            .collection('workouts')
            .doc(user.email)
            .set({
          'exerciseDataList': workoutsSave,
        });
    } else if (!newDoc){
      workouts.collection('workouts').doc(user?.email).update({'exerciseDataList': workoutsSave});
    }

    
  }

}
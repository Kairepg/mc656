import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/data/workout_data.dart';

class UserData {
  String? name;
  String? photo;
  String? mail;
  List<WorkoutData>? workouts;

  UserData({
    required this.name,
    required this.photo,
    required this.mail,
    required this.workouts,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    mail = json['mail'];
    if (json['workouts'] != null) {
      List<WorkoutData> workouts = [];
      json['workouts'].forEach((v) {
        workouts.add(WorkoutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['photo'] = photo;
    data['mail'] = mail;
    if (workouts != null) {
      data['workouts'] = workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static fromFirebase(User? user) {
    return user != null
        ? UserData(
            name: user.displayName ?? "",
            photo: user.photoURL ?? "",
            mail: user.email ?? "",
            workouts: [],
          )
        : [];
  }
}
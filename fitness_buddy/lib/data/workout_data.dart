import 'dart:convert';
import 'package:fitness_buddy/data/exercise_data.dart';

class WorkoutData {
  String? id;
  String? title;
  String? exercises;
  String? minutes;
  int? currentProgress;
  int? progress;
  String? image;
  List<ExerciseData>? exerciseDataList;

  WorkoutData({
    required this.id,
    required this.title,
    required this.exercises,
    required this.minutes,
    required this.currentProgress,
    required this.progress,
    required this.image,
    required this.exerciseDataList,
  });

  WorkoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    exercises = json['exercises'];
    minutes = json['minutes'];
    currentProgress = json['currentProgress'];
    progress = json['progress'];
    image = json['image'];
    if (json['exerciseDataList'] != null) {
      List<ExerciseData> exercises = [];
      json['exerciseDataList'].forEach((v) {
        exercises.add(ExerciseData.fromJson(v));
      });
      exerciseDataList = exercises;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['exercises'] = exercises;
    data['minutes'] = minutes;
    data['currentProgress'] = currentProgress;
    data['progress'] = progress;
    data['image'] = image;
    if (exerciseDataList != null) {
      data['exerciseDataList'] =
          exerciseDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJsonString() {
    final str = json.encode(toJson());
    return str;
  }
}
import 'dart:convert';

class ExerciseData {
  String? id;
  String? title;
  int? minutes;
  double? progress;
  String? video;
  String? description;
  List<String>? steps;

  ExerciseData({
    required this.id,
    required this.title,
    required this.minutes,
    required this.progress,
    required this.video,
    required this.description,
    required this.steps,
  });

  ExerciseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    minutes = json['minutes'];
    progress = json['progress'];
    video = json['video'];
    description = json['description'];
    steps = json['steps'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['minutes'] = minutes;
    data['progress'] = progress;
    data['video'] = video;
    data['description'] = description;
    data['steps'] = steps;
    return data;
  }

  String toJsonString() {
    final str = json.encode(toJson());
    return str;
  }
}
import 'package:shortest_way/models/point_model.dart';

class AnswerModel {
  String id;
  Result result;

  AnswerModel({required this.id, required this.result});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['result'] = result.toJson();
    return data;
  }

  @override
  String toString() {
    return 'AnswerModel{id: $id, result: $result}';
  }
}

class Result {
  List<PointModel> steps;
  String path;

  Result({required this.steps, required this.path});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['steps'] = steps.map((v) => v.toJson()).toList();
    data['path'] = path;
    return data;
  }

  @override
  String toString() {
    return 'Result{steps: $steps, path: $path}';
  }
}

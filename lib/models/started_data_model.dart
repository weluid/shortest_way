import 'package:shortest_way/models/point_model.dart';

class StartedDataModel {
  String? id;
  List<String>? field;
  PointModel? start;
  PointModel? end;

  StartedDataModel({this.id, this.field, this.start, this.end});

  StartedDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = convertDynamicListToStringList(json['field']);
    start = json['start'] != null ? PointModel.fromJson(json['start']) : null;
    end = json['end'] != null ? PointModel.fromJson(json['end']) : null;
  }

  List<String> convertDynamicListToStringList(List<dynamic> dynamicList) {
    return dynamicList.map((element) => element.toString()).toList();
  }

  @override
  String toString() {
    return 'StartedDataModel{id: $id, field: $field, start: $start, end: $end}';
  }
}

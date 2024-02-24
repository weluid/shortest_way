class PointModel {
  int? x;
  int? y;

  PointModel({required this.x, required this.y});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointModel && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  PointModel.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }

  @override
  String toString() {
    return 'PointModel{x: $x, y: $y}';
  }
}

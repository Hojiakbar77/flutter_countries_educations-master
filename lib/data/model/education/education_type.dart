import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class EducationType extends SelectableItem {
  final String type;

  EducationType({
    required super.id,
    required super.name,
    required this.type,
  });

  bool get isUniversity => type == "university";

  bool get isCollege => type == "college";

  bool get isSchool => type == "school";

  factory EducationType.fromJson(Map<String, dynamic> json) {
    return EducationType(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

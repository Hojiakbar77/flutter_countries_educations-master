import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class School extends SelectableItem {
  final int typeId;
  final int districtId;

  School({
    required super.id,
    required super.name,
    required this.typeId,
    required this.districtId,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      typeId: json['type_id'],
      districtId: json['district_id'],
    );
  }
}

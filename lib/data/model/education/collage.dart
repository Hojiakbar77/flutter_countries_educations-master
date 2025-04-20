import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class College extends SelectableItem {
  final int typeId;
  final int districtId;

  College({
    required super.id,
    required super.name,
    required this.typeId,
    required this.districtId,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      id: json['id'],
      name: json['name'],
      typeId: json['type_id'],
      districtId: json['district_id'],
    );
  }
}

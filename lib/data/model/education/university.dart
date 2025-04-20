import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class University extends SelectableItem {
  final int typeId;
  final int regionId;

  University({
    required super.id,
    required super.name,
    required this.typeId,
    required this.regionId,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'],
      name: json['name'],
      typeId: json['type_id'],
      regionId: json['region_id'],
    );
  }
}

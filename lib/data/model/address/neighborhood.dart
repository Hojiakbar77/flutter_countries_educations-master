import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class Neighborhood extends SelectableItem {
  final int districtId;

  Neighborhood({
    required super.id,
    required super.name,
    required this.districtId,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) {
    return Neighborhood(
      id: json['id'],
      name: json['name'],
      districtId: json['district_id'],
    );
  }
}

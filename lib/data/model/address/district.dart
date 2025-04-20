import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class District extends SelectableItem {
  final int regionId;

  District({
    required super.id,
    required super.name,
    required this.regionId,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      regionId: json['region_id'],
    );
  }
}

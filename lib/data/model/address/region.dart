import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class Region extends SelectableItem {
  final int countryId;

  Region({
    required super.id,
    required super.name,
    required this.countryId,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
    );
  }
}

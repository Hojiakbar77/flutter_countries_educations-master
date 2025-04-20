import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class Country extends SelectableItem {
  final String code;
  final String dialCode;
  final String flagPath;

  const Country({
    required super.id,
    required super.name,
    required this.code,
    required this.dialCode,
    required this.flagPath,
  });

  bool get isUzbekistan => code == "UZ";

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      flagPath: json['flagPath'],
    );
  }
}

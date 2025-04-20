import 'package:flutter/material.dart';
import 'package:flutter_countries_educations/src/assets/assets.gen.dart';

class FlagImage {
  static Widget getImage({required String countryCode}) {
    final path = 'assets/images/flags/${countryCode.toLowerCase()}.svg';

    return SvgGenImage(path).svg(
      fit: BoxFit.cover,
      placeholderBuilder: (context) => const Icon(Icons.error),
    );
  }
}

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countries_educations/flutter_countries_educations.dart';
import 'package:flutter_countries_educations/presentation/bottom_sheet.dart';
import 'package:flutter_countries_educations/src/assets/assets.gen.dart';

class AddressSelector {
  const AddressSelector();

  // Generic method to load JSON data
  static Future<List<T>> _loadData<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final String jsonString = await rootBundle.loadString(path);
    final jsonList = await Isolate.run(
      () => jsonDecode(jsonString) as List<dynamic>,
    );
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Load all countries
  static Future<List<Country>> _loadCountries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final countries = await _loadData(
      AssetsManager.json.countries,
      Country.fromJson,
    );

    return countries;
  }

  // Fetch country code by country name
  static Future<String> getCountryCodeByName(String countryName) async {
    final countries = await _loadCountries();
    final country = countries.firstWhere(
      (country) => country.name == countryName,
      orElse: () => Country(
        id: 239,
        name: "Uzbekistan",
        code: "UZ",
        dialCode: "+998",
        flagPath: "assets/images/flags/uz.svg",
      ),
    );
    return country.code;
  }

  // Load regions by country ID
  static Future<List<Region>> _loadRegions(int? countryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final List<Region> regions = await _loadData(
      AssetsManager.json.regions,
      Region.fromJson,
    );

    if (countryId != null) {
      return regions.where((region) => region.countryId == countryId).toList();
    }
    return regions;
  }

  // Load districts by region ID
  static Future<List<District>> _loadDistricts(int? regionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final districts = await _loadData(
      AssetsManager.json.districts,
      District.fromJson,
    );

    if (regionId != null) {
      return districts
          .where((district) => district.regionId == regionId)
          .toList();
    }
    return districts;
  }

  // Load neighborhoods by district ID
  static Future<List<Neighborhood>> _loadNeighborhoods(int? districtId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final neighborhoods = await _loadData(
      AssetsManager.json.neighborhoods,
      Neighborhood.fromJson,
    );

    if (districtId != null) {
      return neighborhoods
          .where((neighborhood) => neighborhood.districtId == districtId)
          .toList();
    }
    return neighborhoods;
  }

  // Dial Code Selector Widget
  static Widget dialCode({
    required String title,
    required void Function(Country?) onItemSelect,
    required Widget Function(BuildContext) builder,
    Country? selectedCountry,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    selectedCountry ??= Constants.uzbekistan;

    return BottomSheetBuilder<Country>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      load: _loadCountries,
      initialValue: selectedCountry,
      lightColor: lightColor,
      darkColor: darkColor,
      foregroundItemBuilder: (context, item) {
        return ListTile(
          leading: ClipOval(
            child: SizedBox(
              width: 40,
              height: 40,
              child: SvgGenImage(item.flagPath).svg(fit: BoxFit.fill),
            ),
          ),
          title: Text(
            item.name,
            style: titleTextStyle,
          ),
          subtitle: Text(
            item.dialCode,
            style: subtitleTextStyle,
          ),
          trailing: selectedCountry != null && selectedCountry.id == item.id
              ? const Icon(Icons.radio_button_checked, color: Colors.blue)
              : null,
        );
      },
    );
  }

  // Country Selector Widget
  static Widget country({
    required String title,
    required void Function(Country?) onItemSelect,
    required Widget Function(BuildContext) builder,
    Country? selectedCountry,
    TextStyle? textStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    return BottomSheetBuilder<Country>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      load: _loadCountries,
      initialValue: selectedCountry,
      lightColor: lightColor,
      darkColor: darkColor,
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedCountry != null && selectedCountry.id == item.id
              ? const Icon(Icons.radio_button_checked, color: Colors.blue)
              : null,
        );
      },
    );
  }

  // Region Selector Widget
  static Widget region({
    required String title,
    required int? countryId,
    required void Function(Region?) onItemSelect,
    required Widget Function(BuildContext) builder,
    Region? selectedRegion,
    TextStyle? textStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    return BottomSheetBuilder<Region>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      load: () => _loadRegions(countryId),
      initialValue: selectedRegion,
      lightColor: lightColor,
      darkColor: darkColor,
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedRegion != null && selectedRegion.id == item.id
              ? const Icon(Icons.radio_button_checked, color: Colors.blue)
              : null,
        );
      },
    );
  }

  // District Selector Widget
  static Widget district({
    required String title,
    required int? regionId,
    required void Function(District?) onItemSelect,
    required Widget Function(BuildContext) builder,
    District? selectedDistrict,
    TextStyle? textStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    return BottomSheetBuilder<District>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      load: () => _loadDistricts(regionId),
      initialValue: selectedDistrict,
      lightColor: lightColor,
      darkColor: darkColor,
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedDistrict != null && selectedDistrict.id == item.id
              ? const Icon(Icons.radio_button_checked, color: Colors.blue)
              : null,
        );
      },
    );
  }

  // Neighborhood Selector Widget
  static Widget neighborhood({
    required String title,
    required int? districtId,
    required void Function(Neighborhood?) onItemSelect,
    required Widget Function(BuildContext) builder,
    Neighborhood? selectedNeighborhood,
    TextStyle? textStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    return BottomSheetBuilder<Neighborhood>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      load: () => _loadNeighborhoods(districtId),
      initialValue: selectedNeighborhood,
      lightColor: lightColor,
      darkColor: darkColor,
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing:
              selectedNeighborhood != null && selectedNeighborhood.id == item.id
                  ? const Icon(Icons.radio_button_checked, color: Colors.blue)
                  : null,
        );
      },
    );
  }
}

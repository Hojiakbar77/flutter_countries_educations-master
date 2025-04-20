import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countries_educations/flutter_countries_educations.dart';
import 'package:flutter_countries_educations/presentation/bottom_sheet.dart';
import 'package:flutter_countries_educations/src/assets/assets.gen.dart';

class EducationSelector<T> {
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

  static Future<List<EducationType>> _loadEducationType() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final educationType = await _loadData(
      AssetsManager.json.educationsTypes,
      EducationType.fromJson,
    );

    return educationType;
  }

  static Future<List<School>> _loadSchools(int? districtId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final schools = await _loadData(
      AssetsManager.json.schools,
      School.fromJson,
    );

    List<School> filteredSchools = [];

    if (districtId != null) {
      filteredSchools = schools.where((school) {
        return school.districtId == districtId;
      }).toList();
    }

    return filteredSchools;
  }

  static Future<List<College>> _loadColleges(int? districtId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final colleges = await _loadData(
      AssetsManager.json.colleges,
      College.fromJson,
    );

    List<College> filteredColleges = [];

    if (districtId != null) {
      filteredColleges = colleges.where((college) {
        return college.districtId == districtId;
      }).toList();
    }

    return filteredColleges;
  }

  static Future<List<University>> _loadUniversities(int? regionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final universities = await _loadData(
      AssetsManager.json.universities,
      University.fromJson,
    );

    List<University> filteredUniversities = [];

    if (regionId != null) {
      filteredUniversities = universities.where((university) {
        return university.regionId == regionId;
      }).toList();
    }

    return filteredUniversities;
  }

  static Widget educationType({
    required String title,
    required void Function(EducationType?) onTypeSelect,
    required Widget Function(BuildContext) builder,
    EducationType? selectedType,
    TextStyle? textStyle,
    Color? lightColor, // Add light color
    Color? darkColor, // Add dark color
  }) {
    return BottomSheetBuilder<EducationType>(
      title: title,
      onItemSelect: onTypeSelect,
      builder: builder,
      initialValue: selectedType,
      load: _loadEducationType,
      lightColor: lightColor, // Pass light color
      darkColor: darkColor, // Pass dark color
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedType != null && selectedType.id == item.id
              ? const Icon(
                  Icons.radio_button_checked,
                  color: Constants.checkboxColor,
                )
              : null,
        );
      },
    );
  }

  static Widget school({
    required String title,
    required int? districtId,
    required void Function(School?) onItemSelect,
    required Widget Function(BuildContext) builder,
    School? selectedSchool,
    TextStyle? textStyle,
    Color? lightColor, // Add light color
    Color? darkColor, // Add dark color
  }) {
    return BottomSheetBuilder<School>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      initialValue: selectedSchool,
      load: () => _loadSchools(districtId),
      lightColor: lightColor, // Pass light color
      darkColor: darkColor, // Pass dark color
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedSchool != null && selectedSchool.id == item.id
              ? const Icon(
                  Icons.radio_button_checked,
                  color: Constants.checkboxColor,
                )
              : null,
        );
      },
    );
  }

  static Widget college({
    required String title,
    required int? districtId,
    required void Function(College?) onItemSelect,
    required Widget Function(BuildContext) builder,
    College? selectedCollege,
    TextStyle? textStyle,
    Color? lightColor, // Add light color
    Color? darkColor, // Add dark color
  }) {
    return BottomSheetBuilder<College>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      initialValue: selectedCollege,
      load: () => _loadColleges(districtId),
      lightColor: lightColor, // Pass light color
      darkColor: darkColor, // Pass dark color
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing: selectedCollege != null && selectedCollege.id == item.id
              ? const Icon(
                  Icons.radio_button_checked,
                  color: Constants.checkboxColor,
                )
              : null,
        );
      },
    );
  }

  static Widget university({
    required String title,
    required int? regionId,
    required void Function(University?) onItemSelect,
    required Widget Function(BuildContext) builder,
    University? selectedUniversity,
    TextStyle? textStyle,
    Color? lightColor, // Add light color
    Color? darkColor, // Add dark color
  }) {
    return BottomSheetBuilder<University>(
      title: title,
      onItemSelect: onItemSelect,
      builder: builder,
      initialValue: selectedUniversity,
      load: () => _loadUniversities(regionId),
      lightColor: lightColor, // Pass light color
      darkColor: darkColor, // Pass dark color
      foregroundItemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name, style: textStyle),
          trailing:
              selectedUniversity != null && selectedUniversity.id == item.id
                  ? const Icon(
                      Icons.radio_button_checked,
                      color: Constants.checkboxColor,
                    )
                  : null,
        );
      },
    );
  }
}

// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_countries_educations/flutter_countries_educations.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Country? _country;
  Region? _region;
  District? _district;
  Neighborhood? _neighborhood;
  EducationType? _educationType;
  Region? _educationRegion;
  District? _educationDistrict;
  School? _school;
  College? _college;
  University? _university;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Dial Code"),
              AddressSelector.dialCode(
                title: _country?.name ?? 'Select Country',
                onItemSelect: (country) {
                  setState(() {
                    _country = country;
                  });
                },
                selectedCountry: _country,
                builder: (context) => ElevatedButton(
                  onPressed: null,
                  child: Text(
                    _country?.name ?? 'Select Country',
                  ),
                ),
              ),
              const Text("Address"),
              AddressSelector.country(
                title: _country?.name ?? 'Select Country',
                onItemSelect: (country) {
                  setState(() {
                    _country = country;
                  });
                },
                selectedCountry: _country,
                builder: (context) => ElevatedButton(
                  onPressed: null,
                  child: Text(
                    _country?.name ?? 'Select Country',
                  ),
                ),
              ),
              if (_country != null)
                AddressSelector.region(
                  title: 'Select Region',
                  selectedRegion: _region,
                  countryId: _country?.id,
                  onItemSelect: (region) {
                    setState(() {
                      _region = region;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select Region'),
                  ),
                ),
              if (_region != null)
                AddressSelector.district(
                  regionId: _region?.id,
                  title: 'Select District',
                  onItemSelect: (district) {
                    setState(() {
                      _district = district;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select District'),
                  ),
                ),
              if (_district != null)
                AddressSelector.neighborhood(
                  districtId: _district?.id,
                  title: 'Select Neighborhood',
                  onItemSelect: (neighborhood) {
                    setState(() {
                      _neighborhood = neighborhood;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select Neighborhood'),
                  ),
                ),
              const SizedBox(height: 20),
              const Text("Education"),
              EducationSelector.educationType(
                title: 'Select Education Type',
                selectedType: _educationType,
                onTypeSelect: (educationType) {
                  setState(() {
                    _educationType = educationType;
                  });
                },
                builder: (context) => const ElevatedButton(
                  onPressed: null,
                  child: Text('Select Education Type'),
                ),
              ),
              if (_educationType != null)
                AddressSelector.region(
                  title: 'Select Region',
                  countryId: _country?.id,
                  selectedRegion: _educationRegion,
                  onItemSelect: (region) {
                    setState(() {
                      _educationRegion = region;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select Region'),
                  ),
                ),
              if (!(_educationType?.isUniversity ?? false) &&
                  _educationRegion != null)
                AddressSelector.district(
                  regionId: _educationRegion?.id,
                  title: 'Select District',
                  selectedDistrict: _educationDistrict,
                  onItemSelect: (district) {
                    setState(() {
                      _educationDistrict = district;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select District'),
                  ),
                ),
              if ((_educationType?.isSchool ?? false) &&
                  _educationDistrict != null)
                EducationSelector.school(
                  title: "School",
                  districtId: _educationDistrict?.id,
                  selectedSchool: _school,
                  onItemSelect: (school) {
                    setState(() {
                      _school = school;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select District'),
                  ),
                ),
              if ((_educationType?.isCollege ?? false) &&
                  _educationDistrict != null)
                EducationSelector.college(
                  title: "College",
                  districtId: _educationDistrict?.id,
                  onItemSelect: (college) {
                    setState(() {
                      _college = college;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select College'),
                  ),
                ),
              if ((_educationType?.isUniversity ?? false) &&
                  _educationRegion != null)
                EducationSelector.university(
                  title: "University",
                  regionId: _educationRegion?.id,
                  onItemSelect: (university) {
                    setState(() {
                      _university = university;
                    });
                  },
                  builder: (context) => const ElevatedButton(
                    onPressed: null,
                    child: Text('Select University'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

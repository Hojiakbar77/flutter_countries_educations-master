AddressSelector and EducationSelector
-------------------------------------

The `AddressSelector` and `EducationSelector` classes provide a flexible and efficient way to handle hierarchical data selection in Flutter applications. These classes allow users to choose from a list of countries, regions, districts, neighborhoods, and educational institutions such as schools, colleges, and universities. By leveraging these selectors, developers can create a seamless and intuitive user experience for selecting complex hierarchical data.

### AddressSelector

### Overview

The `AddressSelector` class is designed to facilitate the selection of geographical entities in a structured manner. It allows users to select a country, followed by a region, district, and neighborhood. Each selection dynamically filters the available options for the next level, ensuring that only relevant data is presented.

### Features

-   **Dynamic Filtering**: Each selection filters the available options for the next level, ensuring relevance.
-   **Asynchronous Data Loading**: Data is loaded asynchronously to improve performance and responsiveness.
-   **Customizable UI**: The selector provides hooks for customizing the UI of each item in the list.
-   **Support for Hierarchical Data**: Supports multiple levels of hierarchical data, making it suitable for complex address selection scenarios.

### Methods

-   **_loadData**: Generic method for loading JSON data from assets asynchronously.
-   **_loadCountries**: Loads the list of countries.
-   **_loadRegions**: Loads regions based on the selected country.
-   **_loadDistricts**: Loads districts based on the selected region.
-   **_loadNeighborhoods**: Loads neighborhoods based on the selected district.

### Usage

To use the `AddressSelector`, simply call the desired method (e.g., `country`, `region`) and provide the necessary parameters, such as title, `onItemSelect` callback, and builder function. Here's an example of how to use it for country selection:


```Flexible(
  child: AddressSelector.country(
    title: "Select Country",
    onItemSelect: (country) {
      // Handle country selection
    },
    builder: (context) => Container(
      // Custom UI for the selected item
    ),
  ),
),
```

### EducationSelector

### Overview

The `EducationSelector` class extends the concept of hierarchical selection to educational institutions. It allows users to select an education type (school, college, university), followed by the specific institution based on the selected district or region.

### Features

-   **Dynamic Filtering**: Similar to `AddressSelector`, each selection filters the next level of options.
-   **Asynchronous Data Loading**: Ensures performance and responsiveness.
-   **Customizable UI**: Allows customization of each item's UI.
-   **Educational Institutions**: Supports selection of schools, colleges, and universities.

### Methods

-   **_loadSchools**: Loads schools based on the selected district.
-   **_loadColleges**: Loads colleges based on the selected district.
-   **_loadUniversities**: Loads universities based on the selected region.

### Usage

To use the `EducationSelector`, call the desired method (e.g., `school`, `college`, `university`) and provide the necessary parameters. Example for selecting a school:


```Flexible(
  child: EducationSelector.school(
    title: "Select School",
    districtId: selectedDistrictId,
    onItemSelect: (school) {
      // Handle school selection
    },
    builder: (context) => Container(
      // Custom UI for the selected item
    ),
  ),
),
```

### Integration with FlagImage

For displaying country flags, you can use the `FlagImage` class, which provides a simple way to load and display SVG flags based on country codes. This enhances the visual appeal of the selectors.


```class FlagImage {
  static Widget getImage({required String countryCode}) {
    return SvgGenImage(
      'assets/images/flags/${countryCode.toLowerCase()}.svg',
    ).svg(fit: BoxFit.cover);
  }
}
```

### Example Usage

Here's how you can integrate `FlagImage` in the `AddressSelector` for displaying country flags:


```Flexible(
  child: AddressSelector.country(
    title: "Select Country",
    onItemSelect: (country) {
      // Handle country selection
    },
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              width: 24,
              height: 24,
              child: FlagImage.getImage(
                countryCode: selectedCountry.code,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            selectedCountry.dialCode,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    ),
  ),
),
```

### Conclusion

The `AddressSelector` and `EducationSelector` classes offer a robust and flexible way to handle hierarchical data selection in Flutter applications. By providing dynamic filtering, asynchronous data loading, and customizable UI components, these selectors enhance the user experience and simplify the implementation of complex selection workflows.
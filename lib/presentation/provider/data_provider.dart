import 'package:flutter/material.dart';
import 'package:flutter_countries_educations/data/model/selectable_item.dart';

class InheritedSearchData<T extends SelectableItem> extends InheritedWidget {
  final List<T> data;
  final ValueNotifier<List<T>> filteredDataNotifier;

  InheritedSearchData({
    super.key,
    required this.data,
    required super.child,
  }) : filteredDataNotifier = ValueNotifier(data);

  void filterData(String query) {
    if (query.isEmpty) {
      filteredDataNotifier.value = data;
    } else {
      filteredDataNotifier.value = data
          .where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  static InheritedSearchData<T> of<T extends SelectableItem>(
    BuildContext context,
  ) {
    final InheritedSearchData<T>? result =
        context.dependOnInheritedWidgetOfExactType<InheritedSearchData<T>>();

    assert(result != null, 'No InheritedSearchData found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(InheritedSearchData oldWidget) {
    return data != oldWidget.data;
  }
}

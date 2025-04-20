import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countries_educations/data/model/selectable_item.dart';
import 'package:flutter_countries_educations/presentation/provider/data_provider.dart';

class BottomSheetBuilder<T extends SelectableItem> extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  final Widget Function(BuildContext, T) foregroundItemBuilder;
  final Future<List<T>> Function() load;
  final String title;
  final T? initialValue;
  final void Function(T?)? onItemSelect;
  final Color? lightColor; // Add light color
  final Color? darkColor; // Add dark color

  const BottomSheetBuilder({
    super.key,
    required this.builder,
    required this.load,
    this.onItemSelect,
    required this.foregroundItemBuilder,
    required this.title,
    this.initialValue,
    this.lightColor,
    this.darkColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCountrySelector(context),
      child: builder(context),
    );
  }

  void _showCountrySelector(BuildContext context) async {
    await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? darkColor ?? const Color(0xff243447)
          : lightColor ?? Colors.white,
      builder: (_) {
        return FutureBuilder<List<T>>(
          future: load(),
          builder: (context, snapshot) {
            final isWaiting = snapshot.connectionState != ConnectionState.done;

            if (isWaiting && !snapshot.hasData) {
              return const _LoadingIndicator();
            } else if (snapshot.hasError) {
              return const _FailedView();
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return InheritedSearchData<T>(
                data: data,
                child: _BottomSheetContent(
                  data: data,
                  foregroundItemBuilder: foregroundItemBuilder,
                  initialValue: initialValue,
                  onItemSelect: onItemSelect,
                ),
              );
            } else {
              return const _FailedView();
            }
          },
        );
      },
    ).then((result) {
      if (result == initialValue) return;

      if (initialValue != null) {
        onItemSelect?.call(result ?? initialValue);
      } else {
        onItemSelect?.call(result);
      }
    });
  }
}

class _BottomSheetContent<T extends SelectableItem> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext, T) foregroundItemBuilder;
  final T? initialValue;
  final void Function(T?)? onItemSelect;
  final Color? lightColor;
  final Color? darkColor;

  const _BottomSheetContent({
    required this.data,
    required this.foregroundItemBuilder,
    this.initialValue,
    this.onItemSelect,
    this.lightColor,
    this.darkColor,
  });

  @override
  Widget build(BuildContext context) {
    final filterProvider = InheritedSearchData.of<T>(context);

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          height: 6,
          width: 34,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff37464f)
                : const Color(0xFFE9EBED),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        _SearchField(
          onChanged: filterProvider.filterData,
          lightColor: lightColor,
          darkColor: darkColor,
        ),
        Expanded(
          child: ValueListenableBuilder<List<T>>(
            valueListenable: filterProvider.filteredDataNotifier,
            builder: (context, filteredData, _) {
              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(filteredData[index]);
                    },
                    child: foregroundItemBuilder(context, filteredData[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _SearchField extends StatelessWidget {
  final Function(String) onChanged;
  final Color? lightColor;
  final Color? darkColor;

  const _SearchField({
    required this.onChanged,
    this.lightColor,
    this.darkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).brightness == Brightness.dark
            ? darkColor ?? const Color(0xff37464f)
            : lightColor ?? Colors.grey[200],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Qidiruv',
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xffffffff)
                : const Color(0xFF9C9C9C),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xffffffff)
                : const Color(0xFF9C9C9C),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class _FailedView extends StatelessWidget {
  const _FailedView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, size: 48, color: Colors.red),
          SizedBox(height: 10),
          Text(
            "Failed to load data",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

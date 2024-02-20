import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final ValueSetter<dynamic> valueSetter;

  const AppDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.valueSetter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputFieldLabel(
          title,
          isRequired: false,
        ),
        const SizedBox(height: 8),
        Container(
          width: context.getScreenWidth(1),
          padding: context.isIOS
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
          decoration: context.isIOS
              ? const BoxDecoration()
              : BoxDecoration(
                  //   color: const Color.fromRGBO(235, 230, 202, 0.25),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    //  color: const Color.fromRGBO(235, 230, 202, 0.25),
                  ),
                ),
          child: Visibility(
            visible: context.isIOS,
            replacement:
                _MaterialDropdown(items: items, valueSetter: valueSetter),
            child: _CupertinoDropdown(items: items, valueSetter: valueSetter),
          ),
        ),
      ],
    );
  }
}

class _CupertinoDropdown extends StatelessWidget {
  final List<String> items;
  final ValueSetter<int> valueSetter;
  const _CupertinoDropdown({required this.items, required this.valueSetter});

  @override
  Widget build(BuildContext context) => CupertinoPicker(
        squeeze: 1.2,
        itemExtent: 32.0,
        useMagnifier: true,
        magnification: 1.22,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: valueSetter,
        scrollController: FixedExtentScrollController(initialItem: 0),
        children: items.map((e) => Text(e)).toList(),
      );
}

class _MaterialDropdown extends StatelessWidget {
  final List<String> items;
  final ValueSetter<String?> valueSetter;
  const _MaterialDropdown({required this.items, required this.valueSetter});

  @override
  Widget build(BuildContext context) => DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        elevation: 0,
        value: items.first,
        items: items
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: valueSetter,
      );
}

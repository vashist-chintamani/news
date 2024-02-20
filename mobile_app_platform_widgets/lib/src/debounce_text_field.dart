import 'package:mobile_app_platform_widgets/common_exports.dart';

class DebounceTextField extends StatelessWidget {
  final bool? enable;
  final bool listen;
  final Widget? suffix;
  final Widget? prefix;
  final bool isRequired;
  final String? inputTitle;
  final String? placeholder;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final int durationInMilliseconds;
  final TextInputType? keyboardType;
  final ValueSetter<String?>? onChanged;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final ValueNotifier<String>? debounceTextNotifier;
  final List<TextInputFormatter>? inputFormatters;

  const DebounceTextField({
    super.key,
    this.onTap,
    this.enable,
    this.suffix,
    this.prefix,
    this.focusNode,
    this.onChanged,
    this.inputTitle,
    this.controller,
    this.placeholder,
    this.listen = false,
    this.inputFormatters,
    this.debounceTextNotifier,
    this.isRequired = false,
    this.durationInMilliseconds = 300,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    Timer? timer;

    final TextEditingController internalController = TextEditingController();

    return ValueListenableBuilder<String>(
      valueListenable: debounceTextNotifier ?? ValueNotifier(""),
      child: Builder(builder: (context) {
        internalController
          ..text = debounceTextNotifier?.value ?? ""
          ..selection =
              TextSelection.collapsed(offset: internalController.text.length);

        return AppTextField(
          onTap: onTap,
          enable: enable,
          suffix: suffix,
          focusNode: focusNode,
          placeholder: placeholder,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          controller: controller ?? internalController,
          prefix: inputTitle != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InputFieldLabel(inputTitle!, isRequired: isRequired),
                )
              : prefix,
          onChanged: (String? value) {
            if (controller != null) {
              controller!.selection =
                  TextSelection.collapsed(offset: controller!.text.length);
            }

            internalController.selection =
                TextSelection.collapsed(offset: internalController.text.length);

            if (timer?.isActive ?? false) {
              timer?.cancel();
            }
            timer = Timer(
              Duration(milliseconds: durationInMilliseconds),
              () {
                if (debounceTextNotifier != null) {
                  debounceTextNotifier!.value = value ?? "";
                }
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
            );
          },
        );
      }),
      builder: (context, newValue, child) {
        internalController
          ..text = newValue
          ..selection =
              TextSelection.collapsed(offset: internalController.text.length);

        if (!listen) {
          return child!;
        }
        return AppTextField(
          onTap: onTap,
          enable: enable,
          suffix: suffix,
          focusNode: focusNode,
          placeholder: placeholder,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          controller: controller ?? internalController,
          prefix: inputTitle != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InputFieldLabel(inputTitle!, isRequired: isRequired),
                )
              : prefix,
          onChanged: (String? value) {
            if (controller != null) {
              controller!.selection =
                  TextSelection.collapsed(offset: controller!.text.length);
            }

            internalController.selection =
                TextSelection.collapsed(offset: internalController.text.length);

            if (timer?.isActive ?? false) {
              timer?.cancel();
            }
            timer = Timer(
              Duration(milliseconds: durationInMilliseconds),
              () {
                if (debounceTextNotifier != null) {
                  debounceTextNotifier!.value = value ?? "";
                }
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
            );
          },
        );
      },
    );
  }
}

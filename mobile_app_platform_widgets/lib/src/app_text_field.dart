import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppTextField extends StatelessWidget {
  final bool? enable;
  final int maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final bool isRequired;
  final bool obscureText;
  final String? inputTitle;
  final String? placeholder;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueSetter<String?>? onChanged;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final ValueNotifier<String>? onChangeNotifier;
  final List<TextInputFormatter>? inputFormatters;
  final bool allowSpecialCharacters;
  final String? initialText;
  final TextStyle? inputLabelTextStyle;
  final AutovalidateMode? autoValidateMode;
  final bool autofocus;
  final int? maxLength;
  final Widget? counter;
  final List<String>? autofillHints;

  const AppTextField({
    super.key,
    this.onTap,
    this.enable,
    this.suffix,
    this.prefix,
    this.counter,
    this.validator,
    this.maxLength,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.inputTitle,
    this.controller,
    this.placeholder,
    this.initialText,
    this.backgroundColor,
    this.inputFormatters,
    this.onChangeNotifier,
    this.autoValidateMode,
    this.autofocus = false,
    this.isRequired = false,
    this.inputLabelTextStyle,
    this.obscureText = false,
    this.allowSpecialCharacters = true,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.words,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    if (false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (inputTitle != null) ...[
            InputFieldLabel(inputTitle!, isRequired: isRequired)
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: context.getScreenWidth(1) - (suffix != null ? 80 : 32),
                child: ColoredBox(
                  color: backgroundColor ?? context.canvasColor,
                  child: CupertinoTextFormFieldRow(
                    onTap: onTap,
                    obscureText: obscureText,
                    validator: validator,
                    autocorrect: false,
                    focusNode: focusNode,
                    controller: controller,
                    placeholder: placeholder,
                    readOnly: enable ?? false,
                    maxLines: maxLines,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    padding: const EdgeInsets.all(12),
                    textCapitalization:
                        textCapitalization ?? TextCapitalization.words,
                    prefix: prefix,
                    onChanged: (String? value) {
                      if (onChanged != null) {
                        onChanged!(value);
                      }
                      if (onChangeNotifier != null) {
                        onChangeNotifier?.value = value ?? "";
                      }

                      if (controller != null) {
                        controller!.selection = TextSelection.collapsed(
                            offset: controller!.text.length);
                      }
                    },
                  ),
                ),
              ),
              if (suffix != null) ...{suffix!}
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (inputTitle != null) ...[
            InputFieldLabel(
              inputTitle!,
              isRequired: isRequired,
              inputLabelTextStyle: inputLabelTextStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            onTap: onTap,
            enabled: enable,
            autocorrect: false,
            maxLines: maxLines,
            maxLength: maxLength,
            autofocus: autofocus,
            validator: validator,
            focusNode: focusNode,
            autofillHints: autofillHints,
            cursorColor: context.primaryColorDark,
            style: TextStyle(
              color: !(enable ?? true) ? context.primaryColorDark.withOpacity(0.6) : null
            ),
            onChanged: (String? value) {
              if (onChanged != null) {
                onChanged!(value);
              }
              if (onChangeNotifier != null) {
                onChangeNotifier?.value = value ?? "";
              }
            },
            controller: controller,
            obscureText: obscureText,
            readOnly: enable ?? false,
            initialValue: initialText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            autovalidateMode: autoValidateMode,
            textCapitalization: textCapitalization ?? TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              counter: counter,
              prefixIcon: prefix,
              suffixIcon: suffix,
              hintText: placeholder,
            ),
          ),
        ],
      );
    }
  }
}

class InputFieldLabel extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final TextStyle? inputLabelTextStyle;

  const InputFieldLabel(this.labelText,
      {super.key, this.isRequired = true, this.inputLabelTextStyle});

  @override
  Widget build(BuildContext context) => Text(
        "$labelText${isRequired ? "*" : ""}",
        style: inputLabelTextStyle ??
            TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: context.isDarkMode ? Colors.white : context.focusColor,
            ),
      );
}

import 'package:mobile_app_platform_widgets/common_exports.dart';

class PasswordTextField extends StatelessWidget {
  final bool? enable;
  final Widget? prefix;
  final bool isRequired;
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

  const PasswordTextField({
    super.key,
    this.onTap,
    this.enable,
    this.prefix,
    this.validator,
    this.focusNode,
    this.onChanged,
    this.inputTitle,
    this.controller,
    this.placeholder,
    this.backgroundColor,
    this.inputFormatters,
    this.onChangeNotifier,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    bool show = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return AppTextField(
          onTap: onTap,
          enable: enable,
          obscureText: show,
          autofillHints: const [AutofillHints.password],
          suffix: GestureDetector(
              onTap: () => setState(() => show = !show),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.string(
                  show ? SvgIcons.eyeOff : SvgIcons.eyeOn,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              )),
          prefix: prefix,
          validator: validator,
          focusNode: focusNode,
          onChanged: onChanged,
          inputTitle: inputTitle,
          controller: controller,
          isRequired: isRequired,
          placeholder: placeholder,
          keyboardType: keyboardType,
          backgroundColor: backgroundColor,
          inputFormatters: inputFormatters,
          onChangeNotifier: onChangeNotifier,
          textCapitalization: textCapitalization,
        );
      },
    );
  }
}

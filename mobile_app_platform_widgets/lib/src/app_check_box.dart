import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final ValueSetter<bool?> onChanged;

  const AppCheckBox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Checkbox(
        value: value,
        fillColor: MaterialStatePropertyAll(context.primaryColor),
        onChanged: onChanged,
        checkColor: Colors.white,
      );
}

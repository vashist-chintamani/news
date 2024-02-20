import 'package:mobile_app_platform_widgets/common_exports.dart';

class SwitchBarButton extends StatelessWidget {
  final String? text;
  final bool value;
  final ValueSetter<bool?> onChanged;

  const SwitchBarButton({
    super.key,
    this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (text != null) ...{
            Text(
              text!,
              style: const TextStyle(fontSize: 20),
            ),
          },
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (text != null) ...{
            Text(
              text!,
              style: const TextStyle(fontSize: 20),
            ),
          },
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      );
    }
  }
}

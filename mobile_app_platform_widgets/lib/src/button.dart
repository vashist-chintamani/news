import 'package:mobile_app_platform_widgets/common_exports.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        child: child,
      );
    } else {
      return TextButton(
        onPressed: onTap,
        child: child,
      );
    }
  }
}

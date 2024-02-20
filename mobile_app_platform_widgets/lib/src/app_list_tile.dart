import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppListTile extends StatelessWidget {
  final String text;
  final Widget? subText;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  const AppListTile({
    super.key,
    this.onTap,
    this.leading,
    this.subText,
    this.trailing,
    this.textStyle,
    required this.text,
    this.backgroundColor,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return CupertinoListTile(
        onTap: onTap,
        leading: leading,
        subtitle: subText,
        trailing: trailing,
        padding: contentPadding,
        backgroundColor: backgroundColor,
        title: Text(
          text,
          style: textStyle,
        ),
      );
    } else {
      return ListTile(
        leading: leading,
        trailing: trailing,
        contentPadding: contentPadding,
        visualDensity: const VisualDensity(
          horizontal: 4,
          vertical: -4,
        ),
        title: Text(text, style: textStyle),
        onTap: onTap,
        subtitle: subText,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
    }
  }
}

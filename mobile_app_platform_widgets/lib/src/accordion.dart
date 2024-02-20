import 'package:mobile_app_platform_widgets/common_exports.dart';

class Accordion extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? leading;
  final IconData expandIcon;
  final TextStyle? textStyle;
  final IconData expandedIcon;
  final Color? backgroundColor;
  final bool initialExpandValue;
  final int animationMilliseconds;
  final EdgeInsets? contentPadding;
  final EdgeInsetsGeometry? padding;

  const Accordion({
    super.key,
    this.leading,
    this.padding,
    this.textStyle,
    required this.title,
    required this.content,
    this.initialExpandValue = false,
    this.animationMilliseconds = 300,
    this.contentPadding = EdgeInsets.zero,
    this.expandedIcon = Icons.arrow_drop_up,
    this.expandIcon = Icons.arrow_drop_down,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    bool expandContent = initialExpandValue;
    return StatefulBuilder(
      builder: (_, setStater) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  elevation: 0,
                  color: backgroundColor,
                  margin: EdgeInsets.zero,
                  borderOnForeground: false,
                  shape: const ContinuousRectangleBorder(),
                  child: AppListTile(
                    text: title,
                    textStyle: textStyle,
                    leading: leading,
                    trailing: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(expandContent ? expandedIcon : expandIcon),
                      onPressed: () =>
                          setStater(() => expandContent = !expandContent),
                    ),
                  )),
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: animationMilliseconds),
                child: !expandContent ? const SizedBox.shrink() : content,
              )
            ],
          ),
        );
      },
    );
  }
}

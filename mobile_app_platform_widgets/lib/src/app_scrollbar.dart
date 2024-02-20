import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppScrollbar extends StatelessWidget {
  final Widget child;
  final Radius? radius;
  final double? thickness;
  final bool disableScrollbar;
  final ScrollController? controller;

  const AppScrollbar({
    super.key,
    this.radius,
    this.thickness,
    this.controller,
    required this.child,
    this.disableScrollbar = false,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      if (disableScrollbar) {
        return child;
      }
      return CupertinoScrollbar(
        thumbVisibility: false,
        controller: controller,
        thickness: thickness ?? 3,
        thicknessWhileDragging: 8,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: child,
      );
    } else {
      if (disableScrollbar) {
        return child;
      }
      return Scrollbar(
        radius: radius,
        interactive: false,
        thickness: thickness,
        thumbVisibility: false,
        controller: controller,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: child,
      );
    }
  }
}

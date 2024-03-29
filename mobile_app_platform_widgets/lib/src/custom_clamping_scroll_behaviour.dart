import 'package:mobile_app_platform_widgets/common_exports.dart';

class CustomClampingScrollPhysics extends ClampingScrollPhysics {
  const CustomClampingScrollPhysics({
    required ScrollPhysics parent,
    this.canUnderScroll = false,
    this.canOverscroll = false,
  }) : super(parent: parent);

  final bool canUnderScroll;

  final bool canOverscroll;

  @override
  CustomClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomClampingScrollPhysics(
        parent: buildParent(ancestor)!,
        canUnderScroll: canUnderScroll,
        canOverscroll: canOverscroll);
  }

  /// Removes the overscroll and underscroll conditions from the original
  /// [ClampingScrollPhysics.applyBoundaryConditions].
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      // underScroll
      return canUnderScroll ? 0.0 : value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      // overscroll
      return canOverscroll ? 0.0 : value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      // hit top edge
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      // hit bottom edge
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }
}

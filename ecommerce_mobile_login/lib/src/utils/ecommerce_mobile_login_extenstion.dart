import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

extension NavigationExtension on BuildContext {
  void pop() => Navigator.of(this).pop();

  void mayBePop() async => await Navigator.of(this).maybePop();

  void popAndPushNamed(String routeName, {Object? arguments}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: arguments);

  Future<void> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.push(
          this,
          appPageRoute(
              (_) => Routes.generateRoute(routeName, arguments: arguments)));

  Future<void> pushNamedAndRemoveUntil(String? routeName,
          {Object? arguments, Widget? screen}) =>
      Navigator.pushAndRemoveUntil(
        this,
        appPageRoute((_) =>
            screen ?? Routes.generateRoute(routeName!, arguments: arguments)),
        (route) => false,
      );

  Future<void> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.pushReplacement(
          this,
          appPageRoute(
              (_) => Routes.generateRoute(routeName, arguments: arguments)));
}

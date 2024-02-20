import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class Routes {
  static const String login = "/login";
  static const String signUpWithPhone = "/signUpWithPhone";
  static const String signUpWithEmail = "/signUpWithEmail";

  static Widget generateRoute(String routeName, {Object? arguments}) {
    switch (routeName) {
      case Routes.login:
        return const Login();
      case Routes.signUpWithPhone:
        return SignUpWithPhone(phone: arguments.toString());
      case Routes.signUpWithEmail:
        return SignUpWithEmail(email: arguments.toString());
      default:
        return const SizedBox.shrink();
    }
  }
}

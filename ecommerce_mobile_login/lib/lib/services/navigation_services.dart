import 'package:tyrios_news_app/utilities/common_exports.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String initializeAppResources = '/';
  static const String settingsPage = '/settingsPage';
  static const String appOnboarding = '/appOnboarding';
  static const String blogDescription = '/blogDescription';
}

class NavigationServices {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return context.appPageRoute((_) => const Login());
      case Routes.settingsPage:
        return context.appPageRoute((_) => const SettingsPage());
      case Routes.appOnboarding:
        return context.appPageRoute((_) => const AppOnboardingScreen());
      case Routes.initializeAppResources:
        return context.appPageRoute((_) => const InitializeAppResources());
      case Routes.blogDescription:
        final Map<String, dynamic> data =
            settings.arguments! as Map<String, dynamic>;
        return context.appPageRoute(
          (_) => BlogDescription(
            blog: data['blog'] as Blog,
            categoryId: data['categoryId'] as int,
          ),
        );
      case Routes.home:
        return context.appPageRoute((_) => const TyriosNewsApp());
      default:
        return context.appPageRoute(
          (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

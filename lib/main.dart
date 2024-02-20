import 'package:ecommerce_mobile_login/generated/l10n.dart'
    as ecommerce_mobile_login_localization;
import 'package:tyrios_news_app/utilities/common_exports.dart';

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Future.wait([
    setupTheme(),
    NotificationManager.init(),
    AppController().setUpHive(),
  ]);
  runApp(const _TYRIOSMaterialApp());
}

class _TYRIOSMaterialApp extends StatelessWidget {
  const _TYRIOSMaterialApp();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
        valueListenable: appThemeMode,
        builder: (context, themeMode, child) {
          context.setPortraitMode();
          AppController().setContext = context;
          return ValueListenableBuilder<bool>(
            valueListenable: AppController().languageNotifier,
            builder: (context, _, child) => MaterialApp(
              themeMode: themeMode,
              theme: AppTheme().light,
              darkTheme: AppTheme().dark,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.initializeAppResources,
              navigatorKey: NavigationServices.navigatorKey,
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(AppController().getLanguageCode),
              onGenerateRoute: NavigationServices.generateRoute,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                S.delegate,
                ecommerce_mobile_login_localization.S.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                strings = S.of(context);
                return StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder:
                      (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                    final ConnectivityResult? result = appController
                        .internetConnectionState.value = snapshot.data;
                    if (snapshot.hasData) {
                      if (result == ConnectivityResult.mobile) {
                        return child!;
                      } else if (result == ConnectivityResult.wifi) {
                        return child!;
                      } else {
                        return AnnotatedRegion(
                          value: context.isDarkMode
                              ? SystemUiOverlayStyle.light.copyWith(
                                  statusBarIconBrightness: Brightness.light)
                              : SystemUiOverlayStyle.dark.copyWith(
                                  statusBarIconBrightness: Brightness.dark),
                          child: MediaQuery(
                            data: MediaQuery.of(context)
                                .removePadding(removeTop: true),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: kToolbarHeight,
                                  width: double.infinity,
                                  child: ColoredBox(
                                    color: context.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                Material(
                                  color: Colors.red,
                                  child: SizedBox(
                                    height: 36,
                                    width: context.screenWidth,
                                    child: const Center(
                                      child: Text("No Internet connection"),
                                    ),
                                  ),
                                ),
                                Expanded(child: child!),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return child!;
                    }
                  },
                );
              },
            ),
          );
        },
      );
}

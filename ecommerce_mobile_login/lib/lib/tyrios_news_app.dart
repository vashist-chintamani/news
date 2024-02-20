import 'package:tyrios_news_app/utilities/common_exports.dart';

class TyriosNewsApp extends StatefulWidget {
  const TyriosNewsApp({super.key});

  @override
  State<TyriosNewsApp> createState() => _TyriosNewsAppState();
}

class _TyriosNewsAppState extends State<TyriosNewsApp> {
  @override
  void initState() {
    super.initState();
    appController.sliderDrawerKey = GlobalKey<SideMenuState>();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: SideMenu(
          type: SideMenuType.slide,
          key: appController.sliderDrawerKey,
          background: context.scaffoldBackgroundColor,
          menu: SizedBox(
            height: context.screenHeight,
            child: const AppDrawer(),
          ),
          closeIcon: const Icon(
            Icons.close,
            size: 0,
            color: Colors.transparent,
          ),
          child: GestureDetector(
            onTap: appController.sliderCloseDrawer,
            child: ValueListenableBuilder<int>(
              valueListenable: appController.selectedDrawerTabNotifier,
              builder: (context, selectedDrawerTabIndexValue, child) => [
                const BlogScreen(),
                const SizedBox.shrink(),
                const Imprint(),
                const PrivacyPolicy(),
                const TermsOfUse(),
                const SizedBox.shrink(),
                const LanguageScreen(),
                const SettingsPage(),
              ][selectedDrawerTabIndexValue],
            ),
          ),
        ),
      );
}

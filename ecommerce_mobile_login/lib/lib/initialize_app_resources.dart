import 'package:tyrios_news_app/utilities/common_exports.dart';

class InitializeAppResources extends StatefulWidget {
  const InitializeAppResources({super.key});

  @override
  State<InitializeAppResources> createState() => _InitializeAppResourcesState();
}

class _InitializeAppResourcesState extends State<InitializeAppResources> {
  @override
  void initState() {
    super.initState();

    /// INITIALIZING THE RESOURCES
    context.postFrameCallback(
      () => appController.initializeAppResources().whenComplete(
        () {
          if (appController.isFirstTimeUser) {
            appController.setFirstTimeUserFlagToHive = false;
            context.pushNamedAndRemoveUntil(Routes.appOnboarding);
            return;
          }
          context.pushNamedAndRemoveUntil(Routes.home);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        title: kAppName,
        showBackButton: false,
        disableScrollbar: true,
        physics: const NeverScrollableScrollPhysics(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 200),
              SvgPicture.string(
                SvgIcons.logo,
                color: context.isDarkMode ? Colors.white : Colors.black,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 40),
              const AppLoader(),
              const SizedBox(height: 40),
              const BlogCardTabletPortrait(),
              const BlogCardTabletLandscape(),
            ],
          ),
        ),
      );
}

import 'package:tyrios_news_app/utilities/common_exports.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) => AppScaffold(
        showBackButton: false,
        title: strings.termsOfUse,
        leading: const DrawerIcon(),
        physics: const NeverScrollableScrollPhysics(),
        nestedScrollController:
            ScrollController(initialScrollOffset: 44, keepScrollOffset: false),
    body: FutureBuilder(
      future: appController.fetchAppPolicyContents(termsOfUse: true),
      builder: (context, snapshot) {
        return ValueListenableBuilder(
          valueListenable:
          appController.webViewNotifiers[WebNotifierKey.termsOfUse]!,
          builder: (context, notified, child) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                notified) {
              return const AppLoader();
            }

            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return TYRIOSWebViewWidget(
              webViewController: snapshot.data!,
              webNotifierKey: WebNotifierKey.termsOfUse,
            );
          },
        );
      },
    ),
  );
}

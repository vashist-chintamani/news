import 'package:tyrios_news_app/utilities/common_exports.dart';

class Imprint extends StatelessWidget {
  const Imprint({super.key});

  @override
  Widget build(BuildContext context) => AppScaffold(
        showBackButton: false,
        title: strings.imprint,
        leading: const DrawerIcon(),
        physics: const NeverScrollableScrollPhysics(),
        nestedScrollController:
            ScrollController(initialScrollOffset: 44, keepScrollOffset: false),
        body: FutureBuilder(
          future: appController.fetchAppPolicyContents(imprint: true),
          builder: (context, snapshot) {
            return ValueListenableBuilder(
              valueListenable:
                  appController.webViewNotifiers[WebNotifierKey.imprint]!,
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
                  webNotifierKey: WebNotifierKey.imprint,
                );
              },
            );
          },
        ),
      );
}

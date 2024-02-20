import 'package:tyrios_news_app/utilities/common_exports.dart';

class TYRIOSWebViewWidget extends StatelessWidget {
  final WebNotifierKey webNotifierKey;
  final WebViewController webViewController;

  const TYRIOSWebViewWidget({
    required this.webNotifierKey,
    required this.webViewController,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: appController.webViewNotifiers[webNotifierKey]!,
        builder: (context, bool started, child) => Column(
          children: [
            if (started) ...{
              SizedBox(
                height: context.screenHeight / 3,
                child: const Center(child: AppLoader()),
              ),
            },
            Expanded(child: WebViewWidget(controller: webViewController)),
          ],
        ),
      );
}

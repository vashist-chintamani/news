import 'package:tyrios_news_app/utilities/common_exports.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: appController.languageNotifier,
        builder: (context, _, child) => AppScaffold(
          showBackButton: false,
          title: strings.language,
          leading: const DrawerIcon(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  strings.pleaseChooseYourLanguage,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.primaryColorDark,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appController.appLanguages.length,
                separatorBuilder: (context, int index) => const Divider(
                  height: 0,
                  indent: 20,
                  endIndent: 16,
                  thickness: 0.8,
                ),
                itemBuilder: (context, int index) {
                  final String language =
                      appController.appLanguages.elementAt(index);
                  return ListTile(
                    title: Text(language.toUpperCase()),
                    onTap: () => appController.setLanguage = language,
                    trailing: Icon(
                      appController.getLanguageCode == language
                          ? Icons.check
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

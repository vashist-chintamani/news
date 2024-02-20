import 'package:tyrios_news_app/utilities/common_exports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, bool> selectedCategories = {};

    return AppScaffold(
      title: strings.settings,
      leading: const DrawerIcon(),
      body: FutureBuilder(
        future: appController.fetchNewsCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: context.screenHeight / 3,
              child: const Center(child: AppLoader()),
            );
          }
          return Column(
            children: [
              ...appController.blogData.blogCategories.map(
                (e) => StatefulBuilder(
                  builder: (context, setState) => ListTile(
                    subtitle: Text(e.teaserText ?? ''),
                    leading: const Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Icon(Icons.category_outlined),
                    ),
                    title: Text(
                      e.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Switch.adaptive(
                        value: selectedCategories[e.categoryId] ?? false,
                        onChanged: (val) => setState(
                          () => selectedCategories.update(
                            e.categoryId,
                            (_) => val,
                            ifAbsent: () => val,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

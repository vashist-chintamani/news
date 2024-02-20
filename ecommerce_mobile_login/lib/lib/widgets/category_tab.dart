import 'package:tyrios_news_app/utilities/common_exports.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.categoryTabIndex,
        builder: (context, index, child) => Column(
          children: [
            DefaultTabController(
              initialIndex: index,
              length: appController.blogData.blogCategories.length,
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    appController
                      ..sliderCloseDrawer()
                      ..categoryTabIndex.value = index;
                    final int categoryId =
                        appController.blogData.blogCategories[index].id;

                    if (!appController.categoryBlogs.containsKey(categoryId)) {
                      appController.fetchBlogsFromCategory(categoryId);
                    }

                    /// SHOW THE SHIMMER AS A LOADER
                  },
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  tabs: appController.blogData.blogCategories
                      .map((e) => Text(e.title))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
              child: Divider(),
            ),
          ],
        ),
      );
}

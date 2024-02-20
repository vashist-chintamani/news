import 'package:tyrios_news_app/utilities/common_exports.dart';

class CategoryBlogList extends StatelessWidget {
  final int categoryId;

  const CategoryBlogList(this.categoryId, {super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.categoryBlogNotifier,
        builder: (context, _, __) => ValueListenableBuilder(
          valueListenable: appController.pullToRefreshToFetchCategoryBlogs,
          builder: (context, value, _) => FutureBuilder(
            future: appController.notifiers['categoryBlogCallFuture'] as bool
                ? appController.fetchBlogsFromCategory(categoryId)
                : appController.categoryBlogs[categoryId] == null
                    ? appController.fetchBlogsFromCategory(categoryId)
                    : value
                        ? appController.fetchBlogsFromCategory(categoryId)
                        : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return !context.isTablet
                    ? const ShimmerSeparatedMobile()
                    : const ShimmerSeparatedList();
              }
              return ValueListenableBuilder(
                valueListenable: appController.notifyCategoryBlog,
                builder: (context, categoryBlogNotified, child) {
                  final List<Blog> blogList =
                      appController.categoryBlogs[categoryId] ?? [];

                  if (!value && blogList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(CupertinoIcons.search, size: 100),
                            const SizedBox(height: 10),
                            Text(
                              strings.noBlogsAvailable,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: context.primaryColorDark,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 80,
                              child: PrimaryButton(
                                text: strings.retry,
                                onTap: () => appController
                                    .pullToRefreshToFetchCategoryBlogs
                                    .value = true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return context.isTablet
                      ? _CategoryBlogGridTablet(
                          categoryId: categoryId,
                          categoryBlogNotified: categoryBlogNotified,
                          loading: value,
                        )
                      : _CategoryBlogListMobile(
                          categoryId: categoryId,
                          categoryBlogNotified: categoryBlogNotified,
                          loading: value,
                        );
                },
              );
            },
          ),
        ),
      );
}

class _CategoryBlogListMobile extends StatelessWidget {
  final int categoryId;
  final bool categoryBlogNotified;
  final bool loading;

  const _CategoryBlogListMobile({
    required this.categoryId,
    required this.categoryBlogNotified,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final List<Blog> blogList = appController.categoryBlogs[categoryId] ?? [];
    return ListView.separated(
      shrinkWrap: true,
      itemCount: blogList.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: context.screenHeight / 6,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        if (blogList.length == index) {
          if (categoryBlogNotified ||
              appController.getBlogOffset(categoryId) <
                  appController.getBlogTotalCount(categoryId)) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: AppLoader(cupertinoIconSize: 16),
            );
          }
          return const SizedBox.shrink();
        }
        return BlogCard(
          blog: blogList[index],
          latestBlog: index == 0,
          categoryId: categoryId,
        );
      },
    );
  }
}

class _CategoryBlogGridTablet extends StatelessWidget {
  final int categoryId;
  final bool categoryBlogNotified;
  final bool loading;

  const _CategoryBlogGridTablet({
    required this.categoryId,
    required this.categoryBlogNotified,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final List<Blog> blogList = appController.categoryBlogs[categoryId] ?? [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (blogList.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: context.isLandscape
                  ? appController.tabletHeight.landscape.value.height - 40
                  : null,
              child: BlogCardTablet(
                latestBlog: true,
                blog: blogList.first,
                categoryId: categoryId,
              ),
            ),
          ),
        },
        Builder(
          builder: (context) {
            final List<Blog> gridViewBlogs = blogList.skip(1).toList();
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                bottom: gridViewBlogs.length > 1 ? 80 : 0,
                left: 12,
                right: 12,
              ),
              itemCount: gridViewBlogs.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isLandscape ? 3 : 2,
                mainAxisExtent: context.isLandscape
                    ? appController.tabletHeight.landscape.value.height
                    : appController.tabletHeight.portrait.value.height,
              ),
              itemBuilder: (context, index) {
                if (gridViewBlogs.length == index) {
                  if (categoryBlogNotified ||
                      appController.getBlogOffset(categoryId) <
                          appController.getBlogTotalCount(categoryId)) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: AppLoader(cupertinoIconSize: 16),
                    );
                  }
                  return const SizedBox.shrink();
                }
                return BlogCard(
                  blog: gridViewBlogs[index],
                  latestBlog: false,
                  categoryId: categoryId,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

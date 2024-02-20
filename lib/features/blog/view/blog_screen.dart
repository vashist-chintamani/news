import 'package:tyrios_news_app/utilities/common_exports.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.appNavIndex,
        builder: (_, currentIndex, __) => AppScaffold(
          customSliverAppBar: const SliverAppBarBlogScreen(),
          bottomNavigationBar: const AppBottomNavigationBar(),
          pullToRefreshCallback: currentIndex == 0
              ? () async =>
                  appController.pullToRefreshToFetchCategoryBlogs.value = true
              : null,
          cupertinoTabScaffold: context.isIOS
              ? CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    currentIndex: currentIndex,
                    activeColor: context.primaryColor,
                    inactiveColor: context.primaryColorDark,
                    items: AppBottomNavigationBar.bottomNavBars(context),
                    onTap: (int index) =>
                        appController.appNavIndex.value = index,
                  ),
                  tabBuilder: (context, int index) =>
                      const CupertinoTabBlogScreen())
              : null,
          body: [
            ValueListenableBuilder<int>(
              valueListenable: appController.categoryTabIndex,
              builder: (context, index, child) {
                if (appController.blogData.blogCategories.isEmpty) {
                  return const SizedBox();
                }
                return appController.blogData.blogCategories
                    .map((blogCategory) => CategoryBlogList(blogCategory.id))
                    .toList()[index];
              },
            ),
            const FavouriteBlogs()
          ][currentIndex],
        ),
      );
}

class CupertinoTabBlogScreen extends StatefulWidget {
  const CupertinoTabBlogScreen({super.key});

  @override
  State<CupertinoTabBlogScreen> createState() => _CupertinoTabBlogScreenState();
}

class _CupertinoTabBlogScreenState extends State<CupertinoTabBlogScreen> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.appNavIndex,
        builder: (context, index, child) => AppScaffold(
          showBackButton: false,
          leading: const DrawerIcon(),
          title: index == 1 ? strings.bookmark : '',
          border: context.isDarkMode
              ? Border(
                  bottom: BorderSide(
                    color: context.primaryColor.withOpacity(0.4),
                  ),
                )
              : null,
          customSliverAppBar:
              index == 0 ? const SliverAppBarBlogScreen() : null,
          scrollEndNotificationCallback:
              (ScrollNotification scrollNotification) {
            final int id = appController.blogData
                .blogCategories[appController.categoryTabIndex.value].id;

            if (scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent &&
                scrollNotification.metrics.atEdge &&
                appController.getBlogOffset(id) <
                    appController.getBlogTotalCount(id)) {
              appController
                ..notifyCategoryBlog.value = true
                ..fetchBlogsFromCategory(
                        appController
                            .blogData
                            .blogCategories[
                                appController.categoryTabIndex.value]
                            .categoryId,
                        isInfiniteScroll: true)
                    .whenComplete(
                        () => appController.notifyCategoryBlog.value = false);
            }
          },
          slivers: [
            if (index == 0) ...{
              CupertinoSliverRefreshControl(
                  onRefresh: () async => appController
                      .pullToRefreshToFetchCategoryBlogs.value = true),
            },
            SliverToBoxAdapter(
              child: ValueListenableBuilder<int>(
                valueListenable: appController.categoryTabIndex,
                builder: (context, index, child) {
                  return StreamBuilder<ConnectivityResult>(
                    stream: Connectivity().onConnectivityChanged,
                    builder: (context, snapshot) {
                      final ConnectivityResult? result = snapshot.data;
                      if (appController.blogData.blogCategories.isEmpty) {
                        if ((!snapshot.hasError && result == null) ||
                            result == ConnectivityResult.none) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 88.0),
                            child: NoInternetConnection(
                              noInternetConnectionText: '',
                              tryAgain: '',
                            ),
                          );
                        }
                      }
                      if (result == ConnectivityResult.mobile ||
                          result == ConnectivityResult.wifi) {
                        return appController.blogData.blogCategories
                            .map((blogCategory) =>
                                CategoryBlogList(blogCategory.id))
                            .toList()[index];
                      }
                      return appController.blogData.blogCategories
                          .map((blogCategory) =>
                              CategoryBlogList(blogCategory.id))
                          .toList()[index];
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class SliverAppBarBlogScreen extends StatelessWidget {
  const SliverAppBarBlogScreen({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.appNavIndex,
        builder: (context, index, child) => SliverAppBar(
          pinned: true,
          centerTitle: false,
          leading: const DrawerIcon(),
          floating: index == 1 ? false : true,
          title: const Text(
            kAppName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          bottom: [
            const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: CategoryTab(),
            ),
            PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: SizedBox(
                height: 0,
                child: Divider(
                  color: context.primaryColorDark.withOpacity(0.5),
                ),
              ),
            ),
          ][index],
        ),
      );
}

/*
Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  title: Text("data"),
                  pinned: true,
                  floating: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: CategoryTab(),
                  ),
                ),
              ];
            },
            body: NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                print("scroll");
                print(scroll.metrics.pixels);
                return false;
              },
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Scrollbar(
                  child: CustomScrollView(
                    slivers: [
                      SliverList.list(
                          children: List.generate(100, (index) => Text("data")))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
* */

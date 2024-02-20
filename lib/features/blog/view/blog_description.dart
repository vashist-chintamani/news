import 'package:tyrios_news_app/utilities/common_exports.dart';

class BlogDescription extends StatefulWidget {
  final Blog blog;
  final int categoryId;

  const BlogDescription({
    required this.blog,
    required this.categoryId,
    super.key,
  });

  @override
  State<BlogDescription> createState() => _BlogDescriptionState();
}

class _BlogDescriptionState extends State<BlogDescription> {
  @override
  void initState() {
    super.initState();

    /// SETTING blogDescriptionWebScrollPositionNotifier to TRUE, SO THAT IT SHOWS THE APP BAR INITIALLY
    appController.blogDescriptionWebScrollPositionNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        title: '',
        physics: const NeverScrollableScrollPhysics(),
        showAppBarNotifier:
            appController.blogDescriptionWebScrollPositionNotifier,
        customSliverAppBar: SliverAppBar(
          floating: true,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  child: InkWell(
                    onTap: () => appController.setFavouriteBlog(widget.blog),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: appController.likeButtonNotifier,
                      builder: (context, _, __) => Icon(
                        widget.blog.favourite
                            ? AppIcons.bookmarkFill
                            : AppIcons.bookmark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FittedBox(
                  child: IconButton(
                    onPressed: () {
                      context.showAppLoaderDialog();
                      unawaited(
                        appController
                            .shareBlog(widget.blog)
                            .whenComplete(context.pop),
                      );
                    },
                    icon: const Icon(CupertinoIcons.share, size: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: FutureBuilder(
          future: appController.fetchBlogDescription(
            widget.categoryId,
            widget.blog.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return context.isTablet
                  ? const BlogDescLoadingTablet()
                  : const BlogDescriptionLoading();
            }

            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            final Blog newBlog = snapshot.data!;

            return Column(
              children: [
                const SizedBox(height: 8),
                ValueListenableBuilder(
                  valueListenable:
                      appController.blogDescriptionWebScrollPositionNotifier,
                  builder: (context, notified, child) {
                    if (!notified) {
                      return const SizedBox(height: kToolbarHeight);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: TYRIOSWebViewWidget(
                    webViewController: newBlog.webViewController!,
                    webNotifierKey: WebNotifierKey.blogDescription,
                  ),
                ),
              ],
            );
          },
        ),
      );
}

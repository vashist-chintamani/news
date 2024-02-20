import 'package:tyrios_news_app/utilities/common_exports.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final bool latestBlog;
  final int categoryId;

  const BlogCard({
    required this.blog,
    required this.latestBlog,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.isTablet
      ? BlogCardTablet(
          blog: blog,
          latestBlog: latestBlog,
          categoryId: categoryId,
        )
      : BlogCardMobile(
          blog: blog,
          latestBlog: latestBlog,
          categoryId: categoryId,
        );
}

class BlogCardTablet extends StatelessWidget {
  final Blog blog;
  final bool latestBlog;
  final int categoryId;

  const BlogCardTablet({
    required this.blog,
    required this.latestBlog,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 1,
        child: InkWell(
          onTap: () {
            appController.sliderCloseDrawer();
            context.pushNamed(
              Routes.blogDescription,
              arguments: {
                'blog': blog,
                'categoryId': categoryId,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (blog.teaserImage != null &&
                    context.isLandscape &&
                    latestBlog) ...[
                  const SizedBox(width: 4),
                  TYRIOSCacheImage(
                    height:
                        appController.tabletHeight.landscape.value.height - 40,
                    width: context.screenWidth / 2,
                    imageUrl: blog.teaserImage != null
                        ? appController.getTYRIOSImageURL(blog.teaserImage!)
                        : '',
                  ),
                  const SizedBox(width: 12),
                ],
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if ((blog.teaserImage != null && !latestBlog) ||
                                (blog.teaserImage != null &&
                                    latestBlog &&
                                    !context.isLandscape)) ...[
                              TYRIOSCacheImage(
                                width: context.screenWidth,
                                height: latestBlog
                                    ? context.screenHeight / 3.7
                                    : context.screenHeight / 3.5,
                                imageUrl: blog.teaserImage != null
                                    ? appController
                                        .getTYRIOSImageURL(blog.teaserImage!)
                                    : '',
                              ),
                              const SizedBox(height: 8),
                            ],
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                if (blog.author?.image != null) ...{
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    child: TYRIOSCacheImage(
                                      width: 24,
                                      height: 24,
                                      imageUrl: appController.getTYRIOSImageURL(
                                        blog.author!.image!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                } else ...{
                                  CircleAvatar(
                                    radius: 11,
                                    child: Text(
                                      blog.author!.getFullName[0],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: context.primaryColorDark,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                },
                                Text(
                                  blog.author!.getFullName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                blog.title,
                                maxLines: latestBlog ? 3 : 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (blog.teaserText != null) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  blog.teaserText!,
                                  maxLines: latestBlog ? 5 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${Duration(seconds: blog.readingTime!).inMinutes} ${strings.minRead}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        appController.setFavouriteBlog(blog),
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable:
                                          appController.likeButtonNotifier,
                                      builder: (context, _, __) => Icon(
                                        blog.favourite
                                            ? AppIcons.bookmarkFill
                                            : AppIcons.bookmark,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      context.showAppLoaderDialog();
                                      unawaited(
                                        appController
                                            .shareBlog(blog)
                                            .whenComplete(context.pop),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.ios_share_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BlogCardMobile extends StatelessWidget {
  final Blog blog;
  final bool latestBlog;
  final int categoryId;

  const BlogCardMobile({
    required this.blog,
    required this.latestBlog,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 1,
        child: InkWell(
          onTap: () {
            appController.sliderCloseDrawer();
            context.pushNamed(
              Routes.blogDescription,
              arguments: {
                'blog': blog,
                'categoryId': categoryId,
              },
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (blog.teaserImage != null) ...{
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              child: TYRIOSCacheImage(
                                height: 240,
                                width: double.infinity,
                                imageUrl: appController
                                    .getTYRIOSImageURL(blog.teaserImage!),
                              ),
                            ),
                          ),
                        },
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (blog.author?.image != null) ...{
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      child: TYRIOSCacheImage(
                                        width: 24,
                                        height: 24,
                                        imageUrl:
                                            appController.getTYRIOSImageURL(
                                          blog.author!.image!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  } else ...{
                                    CircleAvatar(
                                      radius: 11,
                                      child: Text(
                                        blog.author!.getFullName[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: context.primaryColorDark,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  },
                                  Text(
                                    blog.author!.getFullName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                blog.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (blog.teaserText != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  blog.teaserText!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Duration(seconds: blog.readingTime!).inMinutes} ${strings.minRead}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => appController.setFavouriteBlog(blog),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: appController.likeButtonNotifier,
                            builder: (context, _, __) => Icon(
                              blog.favourite
                                  ? AppIcons.bookmarkFill
                                  : AppIcons.bookmark,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            context.showAppLoaderDialog();
                            unawaited(
                              appController
                                  .shareBlog(blog)
                                  .whenComplete(context.pop),
                            );
                          },
                          child: const Icon(CupertinoIcons.share, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class BlogCardTabletPortrait extends StatelessWidget {
  const BlogCardTabletPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    final double height =
        context.isPortrait ? context.screenHeight : context.screenWidth;
    return ChildSizeNotifier(
      sizeNotifier: appController.tabletHeight.portrait,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE HEIGHT
                    SizedBox(height: height / 3.5),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'Sunil Bakale',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.transparent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// BLOG TITLE
                    const Text(
                      'In 1992, Tim Berners-Lee circulated a document titled “HTML Tags,” which outlined just 20 tags, many of which are now obsolete or have taken other forms. The first surviving tag to be defined in the document, after the crucial anchor tag, is the paragraph tag. It wasn’t until 1993 that a discussion emerged on the proposed image tag.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// BLOG DESCRIPTION
                    const Text(
                      'In 1992, Tim Berners-Lee circulated a document titled “HTML Tags,” which outlined just 20 tags, many of which are now obsolete or have taken other forms. The first surviving tag to be defined in the document, after the crucial anchor tag, is the paragraph tag. It wasn’t until 1993 that a discussion emerged on the proposed image tag.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '100 min read',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(height: 18),
                        Icon(
                          Icons.ios_share_outlined,
                          size: 20,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlogCardTabletLandscape extends StatelessWidget {
  const BlogCardTabletLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    final double height =
        context.isLandscape ? context.screenHeight : context.screenWidth;
    return ChildSizeNotifier(
      sizeNotifier: appController.tabletHeight.landscape,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height / 3.5),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'Sunil Bakale',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.transparent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'In 1992, Tim Berners-Lee circulated a document titled “HTML Tags,” which outlined just 20 tags, many of which are now obsolete or have taken other forms. The first surviving tag to be defined in the document, after the crucial anchor tag, is the paragraph tag. It wasn’t until 1993 that a discussion emerged on the proposed image tag.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'In 1992, Tim Berners-Lee circulated a document titled “HTML Tags,” which outlined just 20 tags, many of which are now obsolete or have taken other forms. The first surviving tag to be defined in the document, after the crucial anchor tag, is the paragraph tag. It wasn’t until 1993 that a discussion emerged on the proposed image tag.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '100 min read',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(height: 18),
                        Icon(
                          Icons.ios_share_outlined,
                          size: 20,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:tyrios_news_app/utilities/common_exports.dart';

class FavouriteBlogs extends StatelessWidget {
  const FavouriteBlogs({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.likeButtonNotifier,
        builder: (context, _, child) {
          final List<Blog> favouriteBlogs = appController.getFavouriteBlogs;
          return Visibility(
            visible: favouriteBlogs.isNotEmpty,
            replacement: Padding(
              padding: const EdgeInsets.symmetric(vertical: 300),
              child: Center(
                child: Text(
                  strings.noFavouriteBlogsFound,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: context.primaryColorDark,
                  ),
                ),
              ),
            ),
            child: SizedBox(
              height: favouriteBlogs.length == 1
                  ? context.screenHeight / 1.2
                  : null,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: favouriteBlogs.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: favouriteBlogs.length > 1 ? 60 : 0,
                  top: 12,
                  left: 12,
                  right: 12,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) => BlogCard(
                  blog: favouriteBlogs[index],
                  latestBlog: false,
                  categoryId: favouriteBlogs[index].categoryId,
                ),
              ),
            ),
          );
        },
      );
}

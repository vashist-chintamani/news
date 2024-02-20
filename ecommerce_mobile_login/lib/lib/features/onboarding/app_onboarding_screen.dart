import 'package:tyrios_news_app/utilities/common_exports.dart';

final PageController _onboardPageController = PageController();

final ValueNotifier<int> _onboardPageNotifier = ValueNotifier<int>(0);
final List<Map<String, dynamic>> _introList = [
  {
    "title": "title1",
    "subTitle": "Sub_Title1",
    "imageUrl":
        "https://buffer.com/cdn-cgi/image/w=7000,fit=contain,q=90,f=auto/library/content/images/2023/10/free-images.jpg",
  },
  {
    "title": "title2",
    "subTitle": "Sub_Title2",
    "imageUrl":
        "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_640.jpg",
  },
  {
    "title": "title3",
    "subTitle": "Sub_Title3",
    "imageUrl":
        "https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg",
  },
  {
    'title': "title4",
    'subTitle': "Sub_Title4",
    'imageUrl':
        "https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg",
  },
];

class AppOnboardingScreen extends StatelessWidget {
  const AppOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      return const _TabletOnBoardScreen();
    } else {
      return const _MobileOnBoardScreen();
    }
  }
}

class _MobileOnBoardScreen extends StatelessWidget {
  const _MobileOnBoardScreen();

  @override
  Widget build(BuildContext context) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            SizedBox(
              height: context.screenHeight / 1.3,
              child: PageView.builder(
                controller: _onboardPageController,
                itemCount: _introList.length,
                onPageChanged: (int index) =>
                    _onboardPageNotifier.value = index,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> pageView = _introList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          pageView['imageUrl'] as String,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: context.screenHeight / 1.6,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pageView['title'] as String,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pageView['subTitle'] as String,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ValueListenableBuilder(
                valueListenable: _onboardPageNotifier,
                builder: (context, currentSelectedIndex, child) => Row(
                  children: [
                    ...List.generate(
                      _introList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: currentSelectedIndex == index
                              ? context.primaryColor
                              : context.disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                onTap: () => context.pushNamedAndRemoveUntil(Routes.home),
                isExpanded: true,
                text: strings.getStarted,
              ),
            ),
          ],
        ),
      );
}

class _TabletOnBoardScreen extends StatelessWidget {
  const _TabletOnBoardScreen();

  @override
  Widget build(BuildContext context) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: kToolbarHeight),
            SizedBox(
              height: context.screenHeight / 1.4,
              // width: context.screenWidth / 2.0,
              child: PageView.builder(
                controller: _onboardPageController,
                itemCount: _introList.length,
                onPageChanged: (int index) =>
                    _onboardPageNotifier.value = index,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> pageView = _introList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          pageView['imageUrl'] as String,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: context.screenHeight / 1.7,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pageView['title'] as String,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pageView['subTitle'] as String,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                valueListenable: _onboardPageNotifier,
                builder: (context, currentSelectedIndex, child) => Row(
                  children: [
                    ...List.generate(
                      _introList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.7),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: currentSelectedIndex == index
                              ? context.primaryColor
                              : context.disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: context.screenWidth / 2.5,
                child: PrimaryButton(
                  onTap: () => context.pushNamedAndRemoveUntil(Routes.home),
                  text: strings.getStarted,
                ),
              ),
            ),
          ],
        ),
      );
}

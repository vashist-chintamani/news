import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppCarousel<T> extends StatefulWidget {
  final List<T> items;
  final Color activeColor;
  final double carouselHeight;
  final Color indicatorDefaultColor;
  final int autoScrollDurationInSeconds;

  const AppCarousel({
    super.key,
    required this.items,
    this.carouselHeight = 300,
    this.autoScrollDurationInSeconds = 1,
    this.activeColor = const Color(0XFFCDB285),
    this.indicatorDefaultColor = const Color(0XFFEBE6CA),
  });

  @override
  AppCarouselState<T> createState() => AppCarouselState();
}

class AppCarouselState<T> extends State<AppCarousel<T>> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  void _animateToNextImage(int index) => Future.delayed(
      const Duration(seconds: 1),
      () => _pageController.animateToPage(currentIndex = index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    if (widget.items.length >= 2) {
      _animateToNextImage(1);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: widget.carouselHeight,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  if (widget.items.length <= 1 + index) {
                    _animateToNextImage(0);
                    setState(() {});
                    return;
                  }
                  _animateToNextImage(++index);
                  setState(() {});
                },
                children: List.generate(
                  widget.items.length,
                  (index) => Image.asset(
                    widget.items[index].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                widget.items.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 4,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: index == currentIndex
                            ? widget.activeColor
                            : widget.indicatorDefaultColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

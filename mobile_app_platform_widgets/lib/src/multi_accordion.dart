import 'package:mobile_app_platform_widgets/common_exports.dart';

/// TO USE THE MULTI ACCORDION WIDGET, YOU NEED TO PASS THE LIST OF ACCORDION WIDGETS TO IT
class MultiAccordion extends StatelessWidget {
  final Color? separatorColor;
  final Color? backgroundColor;
  final List<Accordion> children;

  MultiAccordion({
    super.key,
    this.separatorColor,
    this.backgroundColor,
    required this.children,
  }) : assert(
            children.isNotEmpty, 'List of Accordion Widgets can not be empty');

  @override
  Widget build(BuildContext context) => Container(
        color: backgroundColor,
        margin: EdgeInsets.zero,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: children.length,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int index) => children[index],
          separatorBuilder: (_, __) => Divider(color: separatorColor),
        ),
      );
}

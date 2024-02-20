import 'package:tyrios_news_app/utilities/common_exports.dart';

class ChildSizeNotifier extends StatefulWidget {
  final Widget child;
  final ValueNotifier<Size> sizeNotifier;

  const ChildSizeNotifier({
    required this.sizeNotifier,
    required this.child,
    super.key,app
  });

  @override
  _ChildSizeNotifierState createState() => _ChildSizeNotifierState();
}

class _ChildSizeNotifierState extends State<ChildSizeNotifier> {
  @override
  void initState() {
    super.initState();
    context.postFrameCallback(_getSize);
  }

  void _getSize() => widget.sizeNotifier.value =
      (context.findRenderObject()! as RenderBox).size;

  @override
  Widget build(BuildContext context) => widget.child;
}

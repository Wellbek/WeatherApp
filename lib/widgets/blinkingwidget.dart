 import 'package:flutter/cupertino.dart';
import 'package:weatherapp/utils.dart';

class BlinkingWidget extends StatefulWidget {
  final Widget child;

  const BlinkingWidget({Key? key, required this.child}): super (key: key);

  @override
  _BlinkingWidgetState createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
import 'package:ck/enum/slide_direction.dart';
import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation(
      {super.key,
      required this.child,
      required this.direction,
      required this.animate,
      this.reset,
      this.animationCompleted});

  final Widget child;
  final SlideDirection direction;
  final bool animate;
  final bool? reset;
  final VoidCallback? animationCompleted;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            if (_animationController.isCompleted) {
              widget.animationCompleted?.call();
            }
          });
    if (widget.animate) { _animationController.forward(); }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlideAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.animate) {
      _animationController.forward();
    }

    if (widget.reset == true) {
      _animationController.reset();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final Animation<Offset> _animation;
    Tween<Offset> tween;
    switch (widget.direction) {
      case SlideDirection.leftAway:
        tween = Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0));
        break;
      case SlideDirection.rightAway:
        tween = Tween<Offset>(begin: Offset(0, 0), end: Offset(1, 0));
        break;
      case SlideDirection.upIn:
        // TODO: Handle this case.
        tween = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case SlideDirection.LeftIn:
        tween = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      // TODO: Handle this case.
      case SlideDirection.rightIn:
        // TODO: Handle this case.
        tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
        break;
      case SlideDirection.none:
      // TODO: Handle this case.
        tween = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0));
        break;
    }

    _animation = tween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

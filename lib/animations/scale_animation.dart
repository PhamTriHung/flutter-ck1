import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation(
      {super.key,
      required this.child,
      required this.animate,
      required this.reset,
      required this.animationCompleted});

  final Widget child;
  final bool animate;
  final bool reset;
  final VoidCallback animationCompleted;

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            if (_animationController.isCompleted) {
              widget.animationCompleted.call();
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ScaleAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.reset) {
      _animationController.reverse();
    }

    if(widget.animate) {
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Animation _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));


    return AnimatedBuilder(animation: _animation, builder: (context, child) {
      return Opacity(opacity: _animation.value,
      child: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
      );
    });
  }
}

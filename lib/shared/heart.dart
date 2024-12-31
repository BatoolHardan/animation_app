import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  late AnimationController controller;
  late Animation<Color?> colorAnimation;
  late Animation<double> sizeAnimation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(controller);

    sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(controller);

    controller.addListener(() {
      print(controller.value);
      print(colorAnimation);
    });

    controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isFav = true;
          });
        }
        if (status == AnimationStatus.dismissed) {
          setState(() {
            isFav = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: colorAnimation.value,
            size: sizeAnimation.value,
          ),
          onPressed: () {
            isFav ? controller.reverse() : controller.forward();
          },
        );
      },
    );
  }
}

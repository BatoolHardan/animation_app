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
  late Animation colorAnimation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(microseconds: 500), vsync: this);

    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(controller);

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
            size: 30,
          ),
          onPressed: () {
            isFav ? controller.reverse() : controller.forward();
          },
        );
      },
    );
  }
}

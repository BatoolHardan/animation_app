import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
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
            controller.forward();
          },
        );
      },
    );
  }
}

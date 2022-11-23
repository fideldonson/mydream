import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Rodkaelk extends StatefulWidget {
  const Rodkaelk({
    Key key,
  }) : super(key: key);

  @override
  State<Rodkaelk> createState() => _RodkaelkState();
}

class _RodkaelkState extends State<Rodkaelk> {
  int roedkaelkFrame = 0;
  Timer roedkaelkTimer;

  double rod1Opacity = 0;
  double rod2Opacity = 0;
  double rod3Opacity = 1;

  nextRoedkaelkTimer() {
    int time;

    roedkaelkFrame++;
    if (roedkaelkFrame > 5) {
      roedkaelkFrame = 0;
    }

    if (roedkaelkFrame == 0) {
      rod1Opacity = 1;
      rod2Opacity = 0;
      rod3Opacity = 1;
      time = 300;
    } else if (roedkaelkFrame == 1) {
      rod1Opacity = 1;
      rod2Opacity = 0;
      rod3Opacity = 0;
      time = 2000 + new Random().nextInt(2000);
    } else if (roedkaelkFrame == 2) {
      rod1Opacity = 1;
      rod2Opacity = 1;
      rod3Opacity = 0;
      time = 300;
    } else if (roedkaelkFrame == 3) {
      rod1Opacity = 0;
      rod2Opacity = 1;
      rod3Opacity = 0;
      time = 2000 + new Random().nextInt(2000);
    } else if (roedkaelkFrame == 4) {
      rod1Opacity = 0;
      rod2Opacity = 1;
      rod3Opacity = 1;
      time = 300;
    } else if (roedkaelkFrame == 5) {
      rod1Opacity = 0;
      rod2Opacity = 0;
      rod3Opacity = 1;
      time = 2000 + new Random().nextInt(2000);
    }
    roedkaelkTimer = new Timer(Duration(milliseconds: time), nextRoedkaelkTimer);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    nextRoedkaelkTimer();
  }

  @override
  void dispose() {
    roedkaelkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: 300,
        ),
        AnimatedOpacity(
          opacity: rod1Opacity,
          duration: Duration(milliseconds: 750),
          child: Image(
            image: AssetImage('assets/rodkaelk1.png'),
          ),
        ),
        AnimatedOpacity(
          opacity: rod2Opacity,
          duration: Duration(milliseconds: 750),
          child: Image(
            image: AssetImage('assets/rodkaelk2.png'),
          ),
        ),
        AnimatedOpacity(
          opacity: rod3Opacity,
          duration: Duration(milliseconds: 750),
          child: Image(
            image: AssetImage('assets/rodkaelk3.png'),
          ),
        ),
      ],
    );
  }
}

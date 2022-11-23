import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class InfoBear extends StatefulWidget {
  const InfoBear({
    Key key,
  }) : super(key: key);

  @override
  State<InfoBear> createState() => _InfoBearState();
}

class _InfoBearState extends State<InfoBear> {
  Timer bearTimer;
  int bearEyeFrame;

  void nextBearTimer() {
    if (bearEyeFrame == 0) {
      bearEyeFrame = 1;

      bearTimer = new Timer(Duration(milliseconds: 250), nextBearTimer);
    } else {
      bearEyeFrame = 0;

      int seconds = 1 + new Random().nextInt(7);
      bearTimer = new Timer(Duration(seconds: seconds), nextBearTimer);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    nextBearTimer();
  }

  @override
  void dispose() {
    bearTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/infobjoern.png'),
          fit: BoxFit.none,
          alignment: Alignment.topLeft,
        ),
        bearEyeFrame == 0
            ? SizedBox.shrink()
            : Image(
                image: AssetImage('assets/infooeje.png'),
              ),
      ],
    );
  }
}

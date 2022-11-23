import 'package:flutter/material.dart';

import 'illustrations/info-bear.dart';

class InfoChildScreen extends StatefulWidget {
  InfoChildScreen({Key key}) : super(key: key);

  @override
  _InfoChildScreenState createState() => _InfoChildScreenState();
}

class _InfoChildScreenState extends State<InfoChildScreen> {
  void backToMain() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).size.width / 2048;
    double topOffset = (MediaQuery.of(context).size.height - (1536 * scale)) / 2;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: topOffset,
            left: 0,
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: Image(
                image: AssetImage('assets/MydreamiPadHistorieBagg.png'),
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Positioned(
            top: topOffset + (300 * scale),
            left: 0,
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: Image(
                image: AssetImage('assets/infotekstipad.png'),
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Positioned(
            top: topOffset + (780 * scale),
            left: (200 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: InfoBear(),
            ),
          ),
          Positioned(
            left: 10,
            top: 20,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              ),
              onPressed: backToMain,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

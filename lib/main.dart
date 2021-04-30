import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';
import 'story.dart';
import 'info.dart';
import 'mydream-modelrepo.dart';
import 'infochild.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();

  runApp(ChangeNotifierProvider(
    create: (context) => MyDreamModel(),
    child: MyDream(),
  ));
}

class MyDream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyDream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'mainScreen',
      routes: {
        'mainScreen': (context) => MainScreen(),
        'infoScreen': (context) => InfoScreen(),
        'infoChildScreen': (context) => InfoChildScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //--------ui---------//
  int bearFrame = 0;
  Timer bearTimer;
  Widget bear = Image(image: AssetImage('assets/bear.png'));

  int bearEyeFrame = 0;
  Timer bearEyeTimer;

  int roedkaelkFrame = 0;
  Timer roedkaelkTimer;
  Widget roedkaelk = Image(
    image: AssetImage('assets/rodkaelk1.png'),
  );
  int hedgehogFrame = 0;
  Timer hedgehogTimer;
  Widget hedgehog = Image(
    image: AssetImage('assets/hedgehog1.png'),
  );
  int hareFrame = 0;
  Timer hareTimer;
  Widget hare = Image(
    image: AssetImage('assets/hare1.png'),
  );

  int godnatFrame = 0;
  Timer godnatTimer;
  Widget godnat = Image(
    image: AssetImage('assets/hedgehog1.png'),
  );

  Widget playIcon = Icon(Icons.play_arrow);

  void showInfo() {
    Navigator.pushNamed(context, 'infoScreen');
  }

  void showInfoChild() {
    Navigator.pushNamed(context, 'infoChildScreen');
  }

  Future playDream(String storyNameParam) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryScreen(
          storyName: storyNameParam,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nextBearTimer();
    nextBearEyeTimer();
    nextRoedkaelkTimer();
    nextHedgehogTimer();
    nextGodnatTimer();
    nextHareTimer();

    //init IAP
    Provider.of<MyDreamModel>(context, listen: false).initializeDB();
  }

  void nextBearTimer() {
    int seconds = 5 + new Random().nextInt(5);
    bearTimer = new Timer(Duration(seconds: seconds), nextBearTimer);

    if (bearFrame == 0) {
      bearFrame = 1;
      bearEyeFrame = 0;
      bear = Image(image: AssetImage('assets/bear_side.png'));
    } else {
      bearFrame = 0;
      bearEyeFrame = 0;
      bear = Image(image: AssetImage('assets/bear.png'));
    }

    setState(() {});
  }

  nextBearEyeTimer() {
    if (bearEyeFrame == 0) {
      bearEyeFrame = 1;

      bearEyeTimer = new Timer(Duration(milliseconds: 250), nextBearEyeTimer);
    } else {
      bearEyeFrame = 0;

      int seconds = 2 + new Random().nextInt(6);
      bearEyeTimer = new Timer(Duration(seconds: seconds), nextBearEyeTimer);
    }

    setState(() {});
  }

  Widget getBearEyes(bFrame, eFrame) {
    if (bFrame == 0) {
      if (eFrame == 0) {
        return null;
      } else {
        return Image(image: AssetImage('assets/bear_closedeyes.png'));
      }
    } else {
      if (eFrame == 0) {
        return null;
      } else {
        return Image(image: AssetImage('assets/bear_side_closedeyes.png'));
      }
    }
  }

  nextRoedkaelkTimer() {
    int seconds = 3 + new Random().nextInt(3);
    roedkaelkTimer = new Timer(Duration(seconds: seconds), nextRoedkaelkTimer);

    if (roedkaelkFrame == 0) {
      roedkaelk = Image(image: AssetImage('assets/rodkaelk1.png'), key: ValueKey<int>(roedkaelkFrame));
      roedkaelkFrame = 1;
    } else if (roedkaelkFrame == 1) {
      roedkaelk = Image(image: AssetImage('assets/rodkaelk2.png'), key: ValueKey<int>(roedkaelkFrame));
      roedkaelkFrame = 2;
    } else if (roedkaelkFrame == 2) {
      roedkaelk = Image(image: AssetImage('assets/rodkaelk3.png'), key: ValueKey<int>(roedkaelkFrame));
      roedkaelkFrame = 3;
    } else if (roedkaelkFrame == 3) {
      roedkaelk = Image(image: AssetImage('assets/rodkaelk2.png'), key: ValueKey<int>(roedkaelkFrame));
      roedkaelkFrame = 0;
    }
    setState(() {});
  }

  nextHedgehogTimer() {
    int seconds;
    if (hedgehogFrame == 0) {
      hedgehog = Image(image: AssetImage('assets/hedgehog1.png'), key: ValueKey<int>(hedgehogFrame));
      hedgehogFrame = 1;
      seconds = 1 + new Random().nextInt(2);
    } else {
      hedgehog = Image(image: AssetImage('assets/hedgehog2.png'), key: ValueKey<int>(hedgehogFrame));
      hedgehogFrame = 0;
      seconds = 1;
    }

    hedgehogTimer = new Timer(Duration(seconds: seconds), nextHedgehogTimer);

    setState(() {});
  }

  nextHareTimer() {
    int seconds;
    if (hareFrame == 0) {
      hare = Image(image: AssetImage('assets/hare1.png'), key: ValueKey<int>(hareFrame));
      hareFrame = 1;
      seconds = 3 + new Random().nextInt(2);
    } else {
      hare = Image(image: AssetImage('assets/hare2.png'), key: ValueKey<int>(hareFrame));
      hareFrame = 0;
      seconds = 1;
    }

    hareTimer = new Timer(Duration(seconds: seconds), nextHareTimer);

    setState(() {});
  }

  nextGodnatTimer() {
    int seconds;
    if (hedgehogFrame == 0) {
      hedgehog = Image(image: AssetImage('assets/hedgehog2.png'), key: ValueKey<int>(hedgehogFrame));
      hedgehogFrame = 1;
      seconds = 1 + new Random().nextInt(2);
    } else {
      hedgehog = Image(image: AssetImage('assets/hedgehog1.png'), key: ValueKey<int>(hedgehogFrame));
      hedgehogFrame = 0;
      seconds = 1;
    }

    hedgehogTimer = new Timer(Duration(seconds: seconds), nextHedgehogTimer);

    setState(() {});
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
                image: AssetImage('assets/Mydream_iPad.png'),
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ),

          //bear
          Positioned(
            top: topOffset + (812 * scale),
            left: (285 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  showInfoChild();
                },
                child: AnimatedSwitcher(
                  switchInCurve: Interval(0.0, 0.5, curve: Curves.linear),
                  switchOutCurve: Interval(0.5, 1.0, curve: Curves.linear),
                  duration: const Duration(milliseconds: 150),
                  child: bear,
                ),
              ),
            ),
          ),

          //bear eyes
          Positioned(
            top: topOffset + (812 * scale),
            left: (285 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: getBearEyes(bearFrame, bearEyeFrame),
            ),
          ),

          //bird
          Positioned(
            top: topOffset + (440 * scale),
            left: (1117 * scale) - 5,
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  playDream("mydream.bird");
                },
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 200,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                          child: Image(
                            image: AssetImage('assets/Poteknap.png'),
                            fit: BoxFit.none,
                            alignment: Alignment.bottomRight,
                          )),
                    ),
                    Container(
                      child: AnimatedSwitcher(
                        switchInCurve: Interval(0.0, 0.5, curve: Curves.linear),
                        switchOutCurve: Interval(0.5, 1.0, curve: Curves.linear),
                        duration: const Duration(milliseconds: 750),
                        child: roedkaelk,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //hare
          Positioned(
            top: topOffset + (800 * scale),
            left: (1560 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  if (Provider.of<MyDreamModel>(context, listen: false).hareLocked) {
                    showParentalGate(context, "mydream.hare");
                  } else {
                    playDream("mydream.hare");
                  }
                },
                child: Stack(
                  // overflow: Overflow.visible,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: 30,
                      left: 210,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                          child: Image(
                            image: AssetImage('assets/Poteknap.png'),
                            fit: BoxFit.none,
                            alignment: Alignment.bottomRight,
                          )),
                    ),
                    Container(
                      child: AnimatedSwitcher(
                        switchInCurve: Interval(0.0, 0.5, curve: Curves.linear),
                        switchOutCurve: Interval(0.5, 1.0, curve: Curves.linear),
                        duration: const Duration(milliseconds: 750),
                        child: hare,
                      ),
                    ),
                    Positioned(
                      top: 230,
                      left: 180,
                      child: Provider.of<MyDreamModel>(context, listen: false).hareLocked
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                              child: Image(
                                image: AssetImage('assets/lock.png'),
                              ))
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //hedgehog
          Positioned(
            top: topOffset + (560 * scale),
            left: (175 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  if (Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked) {
                    showParentalGate(context, "mydream.hedgehog");
                  } else {
                    playDream("mydream.hedgehog");
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  // overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      top: -10,
                      left: 220,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                          child: Image(
                            image: AssetImage('assets/Poteknap.png'),
                            fit: BoxFit.none,
                            alignment: Alignment.bottomRight,
                          )),
                    ),
                    Container(
                      child: AnimatedSwitcher(
                        switchInCurve: Interval(0.0, 0.5, curve: Curves.linear),
                        switchOutCurve: Interval(0.5, 1.0, curve: Curves.linear),
                        duration: const Duration(milliseconds: 750),
                        child: hedgehog,
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 110,
                      child: Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                              child: Image(
                                image: AssetImage('assets/lock.png'),
                              ))
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //godnat
          Positioned(
            top: topOffset + (400 * scale),
            left: (405 * scale),
            child: Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  if (Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked) {
                    showParentalGate(context, "mydream.godnat");
                  } else {
                    playDream("mydream.godnat");
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: -10,
                      left: 220,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                          child: Image(
                            image: AssetImage('assets/Poteknap.png'),
                            fit: BoxFit.none,
                            alignment: Alignment.bottomRight,
                          )),
                    ),
                    Container(
                      child: AnimatedSwitcher(
                        switchInCurve: Interval(0.0, 0.5, curve: Curves.linear),
                        switchOutCurve: Interval(0.5, 1.0, curve: Curves.linear),
                        duration: const Duration(milliseconds: 750),
                        child: godnat,
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 110,
                      child: Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
                              child: Image(
                                image: AssetImage('assets/lock.png'),
                              ))
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
        onPressed: showInfo,
        child: Text(
          "i",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // void showStoryDialog(BuildContext context, String storyID) {
  void showPurchaseModal(BuildContext context, String storyID) async {
    if (!Provider.of<MyDreamModel>(context, listen: false).iapInitialized) {
      await Provider.of<MyDreamModel>(context, listen: false).initializeIAP();
    }

    //check if storyid is bought
    if (storyID == "mydream.hare") {
      if (!Provider.of<MyDreamModel>(context, listen: false).hareLocked) {
        playDream("mydream.hare");
        return;
      }
    } else if (storyID == "mydream.hedgehog") {
      if (!Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked) {
        playDream("mydream.hedgehog");
        return;
      }
    } else if (storyID == "mydream.godnat") {
      if (!Provider.of<MyDreamModel>(context, listen: false).hedgehogLocked) {
        playDream("mydream.godnat");
        return;
      }
    }

    // print("show purchase modal");
    Dialog simpleDialog = Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  leading: Image(image: AssetImage('assets/modalcorner.png')),
                  title: Text(Provider.of<MyDreamModel>(context, listen: false).getProductTitle(storyID)),
                  subtitle: Text(Provider.of<MyDreamModel>(context, listen: false).getProductDescription(storyID) +
                      "\n" +
                      Provider.of<MyDreamModel>(context, listen: false).getProductPrice(storyID)),
                  isThreeLine: true,
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: const Text('KØB REJSEN'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Provider.of<MyDreamModel>(context, listen: false).purchaseProduct(storyID);
                      },
                    ),
                    TextButton(
                      child: const Text('AFBRYD'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));

    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }

  void showParentalGate(BuildContext context, String storyID) async {
    // print("show parental gate");
    var rng = new Random();
    int num1 = 11 + rng.nextInt(10);
    int num2 = 11 + rng.nextInt(10);
    TextEditingController inputController = TextEditingController();

    Container simpleDialog = Container(
      padding: EdgeInsets.all(30),
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(top: 8, left: 8, right: 8),
                leading: Image(image: AssetImage('assets/modalcorner.png')),
                title: Text('Kun for voksne', style: TextStyle(fontSize: 20)),
                // trailing: Text('(1/2)', style: TextStyle(fontSize: 12, color: Colors.blueAccent),),
              ),
              Text(
                'Udregn ' + num1.toString() + ' + ' + num2.toString() + ' for at fortsætte',
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
              Container(
                height: 5,
              ),
              FractionallySizedBox(
                widthFactor: .5,
                child: TextField(
                  autofocus: true,
                  controller: inputController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onEditingComplete: () {
                    if (inputController.text != "") {
                      if ((num1 + num2) == int.parse(inputController.text)) {
                        Navigator.of(context).pop();
                        showPurchaseModal(context, storyID);
                      }
                    }
                  },
                ),
              ),
              Container(
                height: 5,
              ),
              Text('For at fortsætte til købssiden skal en voksen løse regnestykket.'),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text('FORTSÆT'),
                    onPressed: () {
                      if (inputController.text != "") {
                        if ((num1 + num2) == int.parse(inputController.text)) {
                          Navigator.of(context).pop();
                          showPurchaseModal(context, storyID);
                        }
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('AFBRYD'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }
}

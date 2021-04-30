import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class StoryScreen extends StatefulWidget {
  final String storyName;

  StoryScreen({ Key key, this.storyName }) : super(key: key);

  @override
   _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String storyName;
  String progress = "";
  Widget playIcon = Icon(Icons.pause);
  
  int bearFrame = 0;
  Timer bearTimer;
  Widget sleepingBear = Image(image:AssetImage('assets/Sovendebjoern.png'), );
  // Widget sleepingBear1 = Image(image:AssetImage('assets/Sovendebjoern.png'), );
  // Widget sleepingBear2 = Image(image:AssetImage('assets/Sovendebjoerninhal.png'), );


  Duration total;

  void audioProgress(Duration  timePlayed){
      var progressDuration = new Duration(seconds: (total.inSeconds - timePlayed.inSeconds));
      String minutes = progressDuration.inMinutes.toString();
      if(minutes.length <= 1){
        minutes = "0"+minutes;
      }
      String seconds = (progressDuration.inSeconds%60).toString();
      if(seconds.length <= 1){
        seconds = "0"+seconds;
      }
      progress = minutes +":"+seconds;

      if (this.mounted){
        setState(() {});
      }
  }

  Future backToMain() async{
    bearTimer.cancel();
    await advancedPlayer.release();
    Navigator.of(context).pop();
  }

  Future playStory() async{
    advancedPlayer.stop();
    if(storyName == "mydream.bird"){
      total = new Duration(minutes: 12, seconds: 34);
      advancedPlayer = await AudioCache().play('coolkids2mix03.mp3');  

    }else if(storyName == "mydream.hare"){
      total = new Duration(minutes: 11, seconds: 22);
      advancedPlayer = await AudioCache().play('bearpractice.mp3');
    
    }else if(storyName == "mydream.hedgehog"){
      total = new Duration(minutes: 12, seconds: 26);
      advancedPlayer = await AudioCache().play('beartravel.mp3');
      
    }

    advancedPlayer.onAudioPositionChanged.listen( audioProgress );
    advancedPlayer.onPlayerCompletion.listen((event) {
      backToMain();
    });

    playIcon = Icon(Icons.pause);
    if (this.mounted){
      setState(() {
        
      });
    }
  }

  void togglePlayPause() {
    if(advancedPlayer.state == AudioPlayerState.PLAYING){
      advancedPlayer.pause();
      playIcon = Icon(Icons.play_arrow);
    }else{
      advancedPlayer.resume();
      playIcon = Icon(Icons.pause);
    }

    if (this.mounted){
      setState(() { });
    }
  }

  void nextBearTimer (){
    int seconds = 5;
    bearTimer = new Timer(
      Duration(seconds: seconds),
      nextBearTimer
    );

    if(bearFrame == 0){
      sleepingBear = Image(image:AssetImage('assets/Sovendebjoern.png'), key: ValueKey<int>(bearFrame) );
      bearFrame = 1;
    }else{
      sleepingBear = Image(image:AssetImage('assets/Sovendebjoerninhal.png'), key: ValueKey<int>(bearFrame) );
      bearFrame = 0;
    }

    if (this.mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    storyName = widget.storyName;
    print("start story "+storyName);
    
    if(storyName == "bird"){  
      progress = "12:34";
    }else if(storyName == "hare"){
      progress = "11:22";
    }else if(storyName == "hedgehog"){
      progress = "12:26";
    }

    playStory();
    
    nextBearTimer();
  }

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).size.width/2048;
    double topOffset = ( MediaQuery.of(context).size.height - (1536*scale))/2;

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            top: topOffset,
            left: 0,
            child:Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              child:Image(image:AssetImage('assets/MydreamiPadHistorieBagg.png'),fit: BoxFit.none, alignment: Alignment.topLeft, ),
            ),
          ),

          Positioned(
            top: topOffset + (780*scale),
            left: (285*scale),
            child:Transform.scale(
              alignment: Alignment.topLeft,
              scale: scale,
              /* child:Stack(
                children: <Widget>[
                  AnimatedOpacity(
                    opacity:1,
                    duration: Duration(milliseconds: 1500),
                    child: sleepingBear2,
                    onEnd: (){ print("finished"); },
                  ),
                  // sleepingBear1,
                ],
              ) */
              child: AnimatedSwitcher(
                switchInCurve: Interval(0.0, 0.2, curve:Curves.linear ) ,
                switchOutCurve: Interval(0.8, 1.0, curve:Curves.linear ) ,
                duration: const Duration(milliseconds: 3000),
                child: sleepingBear,
              ),
            ),
          ),

          Positioned(
            left: 10,
            top: 20,
            child: ElevatedButton(
              style: ButtonStyle(shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()), foregroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
              onPressed: backToMain,
              child: Icon(Icons.arrow_back, color: Colors.white,),
            ),
          ),


        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(progress, style: TextStyle( color: Colors.white, fontSize: 20, ),),
          ),
          FloatingActionButton(
            backgroundColor: Colors.amber, 
            onPressed: togglePlayPause,
            child: playIcon,
          ),
        ],
      ),
    );
  }
}
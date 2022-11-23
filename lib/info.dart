import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'illustrations/info-bear.dart';
import 'mydream-modelrepo.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void backToMain() {
    Navigator.of(context).pop();
  }

  Future restorePurchases() async {
    var iapStatus = await Provider.of<MyDreamModel>(context, listen: false).initializeIAP();

    if (iapStatus) {
      backToMain();
    } else {
      print('handle error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).size.width / 2048;
    double topOffset = (MediaQuery.of(context).size.height - (1536 * scale)) / 2;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          restorePurchases();
        },
        label: Text("Genopret køb i app'en"),
        backgroundColor: Colors.amber,
      ),
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
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color.fromRGBO(255, 255, 255, 0.55),
              child: SingleChildScrollView(
                child: Text(
                  "Siden tidernes morgen har forældre fortalt deres børn historier. Ældre generationer har videregivet livserfaring til yngre generationer gennem historiefortælling og på denne måde været med til at skabe indsigt og sammenhæng i barnets tilværelse. I dag overvældes mange børn og unge af indtryk og informationer fra hele verden, og der er brug for ro til at samle tankerne.\n\nMed denne app ønsker vi at skabe et rum, som kan være med til at styrke barnets oplevelse af indre ro og tryghed. Gennem små fortællinger, musik og sanseøvelser inviteres barnet med ind i fantasiens og drømmenes verden - fordi der er så meget godt at hente i denne verden!\n\nI historierne møder barnet den rare bjørn, som repræsenterer en tryg relation, men som også kommer ud for forskellige udfordringer, der vækker svære og ubehagelige følelser. Bjørnen blive f.eks. bange, få hjemve eller tvivle på sig selv. De fleste børn kender udmærket disse følelser og føler sig anerkendt og forstået, når også de svære følelser kan rummes og tages alvorligt.\n\nDet særlige ved fortællingerne i denne app, er, at historierne er bygget op omkring den kognitive diamant som tager udgangspunkt i at tanker, følelser, krop og handling hænger sammen! Gennem fortællinger i appen skabes der vekselvirkning og dynamik på hvert af de fire hjørner i denne diamant/psykiske struktur.\n\nDe negative tanker, bekymringer eller katastrofetankerne udfordres af mere realistiske og hjælpsomme tanker. Følelsen af usikkerhed og angst udfordres af mod og lyst. Det kropslige ubehag og den fysiske uro rummes eller aftager gennem guidet åndedræt og afslapning - og undgåelsesadfærden; trangen til at flygte eller stivne, når udfordringerne virker uoverkommelige, udfordres og overvindes gennem små, men sikre skridt i den rigtige retning!\n\nFortællingerne er således bygget op på en måde, hvor viden og værktøjer fra kognitiv terapi og angsthåndtering er flettet ind i historierne, forhåbentlig uden at virke teoretiserende eller belærende, men for at videregive vigtig viden til barnet og hjælpe barnet med at finde indre ro, tryghed og opnå mental balance.\n\nFortællinger er vigtige, fordi de stimulerer barnets evne til at danne indre forestillingsbilleder, og netop denne evne hjælper barnet med at overskue, bearbejde og se sammenhænge i tilværelsen. Samtidig ønsker vi med appen at skabe et sted, hvor der er plads til at stoppe op og mærke efter, sanse og fornemme sig selv!\n\nVi ønsker med musikken og fortællingerne i denne app at skabe et sted, hvor barnet kan mærke efter, føle varme og omsorg og finde sig selv - midt i et univers fuld af drømme, kreativitet og musikalitet!\n\nFarnoush og Søren",
                  style: TextStyle(fontSize: 16),
                ),
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
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
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

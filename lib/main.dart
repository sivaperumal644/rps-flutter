import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool usrWon = false;
  bool optWon = false;
  bool draw = false;
  int o2;
  int u1;
  List<String> images = ['stn', 'ppr', 'scr'];

  int random() {
    int min = 1;
    int max = 4;
    final rdm = new Random();
    int rnd = min + rdm.nextInt(max - min);
    return rnd;
  }

  void dtmWinner() {
    if ((u1 == 1 && o2 == 3) || (u1 == 3 && o2 == 2) || (u1 == 2 && o2 == 1)) {
      setState(() {
        usrWon = true;
        optWon = false;
        draw = false;
      });
    } else if ((u1 == 3 && o2 == 1) ||
        (u1 == 2 && o2 == 3) ||
        (u1 == 1 && o2 == 2)) {
      setState(() {
        usrWon = false;
        optWon = true;
        draw = false;
      });
    } else {
      setState(() {
        draw = true;
        usrWon = false;
        optWon = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PressStart2P'),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 30),
                child: Center(
                  child: Text(
                    'Rock Paper Scissor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )),
            _result(cpu: true),
            _result(),
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      _displayResult(),
                      style: TextStyle(fontSize: 22.0),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _userInput(0),
                _userInput(1),
                _userInput(2),
              ],
            )
          ],
        ),
      ),
    );
  }

  _result({cpu = false}) {
    Color color = cpu
        ? Color.fromARGB(100, 198, 51, 51)
        : Color.fromARGB(100, 0, 122, 255);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: cpu
          ? _columnList(cpu, color).reversed.toList()
          : _columnList(cpu, color),
    );
  }

  List<Widget> _columnList(cpu, color) {
    return [
      Container(margin: EdgeInsets.only(left: 40)),
      Container(
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        width: 120.0,
        height: 120.0,
        child: (_displayImage(cpu)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: color, width: 3.0),
        ),
      ),
      Text(
        cpu ? 'CPU' : 'YOU',
        textAlign: TextAlign.center,
        style:
            TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
      )
    ];
  }

  _displayImage(cpu) {
    String img;
    if (cpu) {
      img = (o2 == null ? null : images[o2 - 1]);
    } else
      img = (u1 == null ? null : images[u1 - 1]);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SvgPicture.asset(
        'assets/$img.svg',
        width: 50,
        height: 50,
      ),
    );
  }

  _displayResult() {
    if (usrWon)
      return 'YOU WON';
    else if (optWon)
      return 'CPU WON';
    else
      return 'DRAW';
  }

  _userInput(index) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 45, 15, 30),
      width: 90.0,
      height: 120.0,
      child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset("assets/${images[index]}.svg"),
            ),
            onTap: () {
              int r = random();
              setState(() {
                o2 = r;
                u1 = index + 1;
              });
              dtmWinner();
            },
          )),
    );
  }
}

import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, bool> score = {};
  var audioCache = AudioCache();
  Map<String, Color> choices = {
    '🍇': Colors.purple,
    '🍎': Colors.red,
    '🔵': Colors.blue,
    '🍋': Colors.yellow,
    '🍊': Colors.orange,
    '🥒': Colors.green,
  };
  int index = 0;
  @override
  Widget build(BuildContext context) {
    print(score);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kids Game"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys
                .map(
                  (item) => Expanded(
                    child: Draggable(
                      data: item,
                      child: score[item] == true
                          ? Text(
                              '✔️',
                              style: TextStyle(fontSize: 40),
                            )
                          : Text(
                              item,
                              style: TextStyle(fontSize: 70),
                            ),
                      feedback: Text(
                        item,
                        style: TextStyle(fontSize: 60),
                      ),
                      childWhenDragging: Text(
                        '⬛',
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                )
                .toList()..shuffle(Random(index+1)),
          ),
          // shuffle .. order Randomly
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices.keys.map((item) => buildTarget(item)).toList()
              ..shuffle(Random(index)),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // to Change Colors Positions
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            index++;
          });
        },
      ),
    );
  }

  Widget buildTarget(item) {
    return DragTarget(
      builder: (context, incoming, target) {
        if (score[item] == true) {
          return Container(
            height: 70,
            width: 110,
            alignment: Alignment.center,
            child: Text(
              "Correct",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            color: Colors.white,
          );
        } else {
          return Container(
            color: choices[item],
            height: 70,
            width: 100,
          );
        }
      },
      //check if data in col 1 == data in col2
      onWillAccept: (String data) => data == item,
      //after on will Accept ,do that
      onAccept: (data) {
        setState(() {
          score[item] = true;
          if (choices.length == score.length) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("You Won , my friend"),
                title: Text("Congratulations!"),
                actions: [
                  TextButton(onPressed: (){
                    setState(() {
                      Navigator.of(context).pop();
                      score.clear();
                    });
                  }, child: Text("Play Again"))
                ],
              ),
            );
          }
          audioCache.play('au.mp3');
        });
      },
    );
  }
}

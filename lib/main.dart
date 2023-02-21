import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/game_methods/game_core.dart';
import 'package:tic_tac_toe_game/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "x";
  Game game = Game();
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  // intital gameboard
  @override
  void initState() {
    super.initState();
    game.borad = Game.initGameBoard();
    print(game.borad);
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue turn".toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(height: 20.0),

          // game board
          Container(
            width: borderWidth,
            height: borderWidth,
            child: GridView.count(
              // ~/ this operator allows you to evide to integer and return an int as a resutl
              crossAxisCount: Game.boradLength ~/ 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                Game.boradLength,
                (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            setState(() {
                              if (game.borad![index] == "") {
                                game.borad![index] = lastValue;
                                turn++;
                                gameOver = game.getWinner(
                                    lastValue, index, scoreboard, 3);
                                if (gameOver) {
                                  result = "$lastValue is the Winner";
                                }else if(!gameOver && turn == 9){
                                  result = "It's a Draw!";
                                }
                                if (lastValue == "X") {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              }
                            });
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      // padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.borad![index],
                          style: TextStyle(
                            color: game.borad![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Text(
            result,
            style: const TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                gameOver = false; 
                game.borad = Game.initGameBoard();
                lastValue = "X"; 
                turn = 0; 
                result = ""; 
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.replay, color: MainColor.accentColor),
            label: const Text("Refresh the Game"),
          )
        ],
      ),
    );
  }
}

class Player{
  static const x = "X"; 
  static const o= "O"; 
  static const empty = ""; 
}

class Game{
  static final boradLength = 9; 
  static final blocSize = 70.0; 
  List<String>? borad; 
  // static List<String>?initGameBoard()=> List.generate(boradLength, (index) => Player.empty); 
  static List<String>?initGameBoard(){
    return List.generate(boradLength, (index) => Player.empty); 
  }
  bool getWinner(String player,int index, List<int> scoreboard,int gridSize){
    int row = index ~/ 3; 
    int col = index % 3; 
    int score = player=="X"? 1: -1; 
    scoreboard[row] += score; 
    scoreboard[gridSize + col] += score; 
    if(gridSize -1 -col == row) scoreboard[2 * gridSize + 1] += score; 

    if(scoreboard.contains(3) || scoreboard.contains(-3)){
      return  true; 
    }
    return false; 
  }
}
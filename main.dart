import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _board;
  late bool _isPlayer1Turn;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _isPlayer1Turn = true;
    _winner = 'U';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _winner == 'U'
                  ? (_isPlayer1Turn ? 'Player 1\'s turn (O)' : 'Player 2\'s turn (X)')
                  : (_winner == 'T' ? 'It\'s a tie!' : 'Player $_winner wins!'),
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (col) {
                    return GestureDetector(
                      onTap: () {
                        _onTileClicked(row, col);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            _board[row][col],
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _resetGame();
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTileClicked(int row, int col) {
    if (_winner == 'U' && _board[row][col] == '') {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? 'O' : 'X';
        _isPlayer1Turn = !_isPlayer1Turn;
        _winner = _checkWinner();
      });
    }
  }

  String _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != '' && _board[i][0] == _board[i][1] && _board[i][1] == _board[i][2]) {
        return _board[i][0];
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] != '' && _board[0][i] == _board[1][i] && _board[1][i] == _board[2][i]) {
        return _board[0][i];
      }
    }

    // Check diagonals
    if (_board[0][0] != '' && _board[0][0] == _board[1][1] && _board[1][1] == _board[2][2]) {
      return _board[0][0];
    }
    if (_board[0][2] != '' && _board[0][2] == _board[1][1] && _board[1][1] == _board[2][0]) {
      return _board[0][2];
    }

    // Check for tie
    bool isTie = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          isTie = false;
          break;
        }
      }
    }
    if (isTie) {
      return 'T';
    }

    // No winner yet
    return 'U';
  }

  void _resetGame() {
    setState(() {
      _initializeBoard();
    });
  }
}

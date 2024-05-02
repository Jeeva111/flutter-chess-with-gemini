import 'package:chess/component/vector2.dart';
import 'package:flutter/material.dart';

import 'package:chess/boards/chess_board.dart';
import 'package:chess/pieces/chess_piece.dart';
import 'package:chess/const.dart';

typedef ListOfMoves = List<List<int>>;

Vector2 vector2InitPos() => Vector2.init();

class RenderBoard extends StatefulWidget {
  final ChessBoard chessBoard;
  final ChessPieceTemplate chessPieces;
  const RenderBoard({super.key, required this.chessBoard, required this.chessPieces});

  @override
  State<RenderBoard> createState() => _RenderBoardState();
}

class _RenderBoardState extends State<RenderBoard> {
  bool isSelected = false;
  late ListOfChessPieces chessPieces;
  ChessPieceData? selectedPiece;
  Vector2 selectedPiecePos = vector2InitPos();

  // A list of white pieces killed by player 2
  List<ChessPieceData> killedWhitePieces = [];

  // A list of black pieces killed by player 1
  List<ChessPieceData> killedBlackPieces = [];

  // A boolean to indicate whose turn it is
  bool isWhiteTrun = true;

  // initial position of king
  List<int> whitekingPos = [ 0, 4 ];
  List<int> blackKingPos = [ 7, 4];
  bool checkStatus = false;


  @override
  void initState() {
    super.initState();
    chessPieces = ChessPiece.generateChessPiece(widget.chessPieces);
  }

  List<Vector2> validMoves = [];

  bool isInBoard(Vector2 coords) => (coords.x >= 0 && coords.x < 8) && (coords.y >= 0 && coords.y < 8);

  // Calculate raw valid moves
  List<Vector2> calculateRawValidMoves(Vector2 coords, ChessPieceData? piece) {
    List<Vector2> candidateMoves = [];
    if(piece == null) {
      return candidateMoves;
    }
    int direction = piece.isPlayer1 ? 1 : -1;
    
    switch (piece.type) {
      case ChessPieceType.rook:
        debugPrint(ChessPieceType.rook.toString());
        // Horizontal and vertical direction
        List<List<int>> directions = [
          [ -1, 0 ], //up
          [ 1, 0 ], //down
          [ 0, -1 ], //left
          [ 0, 1 ], //right
        ];
        for (List<int> dir in directions) {
          var i = 1;
          for (;;) {
            var newRow = coords.x + i * dir[0];
            var newCol = coords.y + i * dir[1];
            var newVector = Vector2(newRow, newCol);
            if (!isInBoard(newVector)) {
              break;
            }
            if (chessPieces[newRow][newCol] != null) {
              if (chessPieces[newRow][newCol]!.isPlayer1 != piece.isPlayer1) {
                candidateMoves.add(newVector);
              }
              break;
            }
            candidateMoves.add(newVector);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
      debugPrint(ChessPieceType.knight.toString());
        List<List<int>> directions = [
          [ -2, -1 ],
          [ -2, 1 ],
          [ -1, -2 ],
          [ -1, 2],
          [ 1, -2],
          [ 1, 2 ],
          [ 2, -1 ],
          [ 2, 1 ],
        ];
        for (List<int> dir in directions) {
            var newRow = coords.x + dir[0];
            var newCol = coords.y + dir[1];
            var newVector = Vector2(newRow, newCol);
            if (!isInBoard(newVector)) {
              continue;
            }
            if (chessPieces[newRow][newCol] != null) {
              if (chessPieces[newRow][newCol]!.isPlayer1 != piece.isPlayer1) {
                candidateMoves.add(newVector);
              }
              continue;
            }
            candidateMoves.add(newVector);
        }
        break;
      case ChessPieceType.bishop:
        debugPrint(ChessPieceType.bishop.toString());
        List<List<int>> directions = [
          [ -1, -1 ], //up
          [ 1, 1 ], //down
          [ 1, -1 ], //left
          [ -1, 1 ], //right
        ];
        for (List<int> dir in directions) {
          var i = 1;
          for (;;) {
            var newRow = coords.x + i * dir[0];
            var newCol = coords.y + i * dir[1];
            var newVector = Vector2(newRow, newCol);
            if (!isInBoard(newVector)) {
              break;
            }
            if (chessPieces[newRow][newCol] != null) {
              if (chessPieces[newRow][newCol]!.isPlayer1 != piece.isPlayer1) {
                candidateMoves.add(newVector);
              }
              break;
            }
            candidateMoves.add(newVector);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        debugPrint(ChessPieceType.queen.toString());
        List<List<int>> directions = [
          [ -1, -1 ],
          [ -1, 1],
          [ -1, 0 ],
          [ 0, -1 ],
          [ 0, 1 ],
          [ 1, -1],
          [ 1, 1 ],
          [ 1, 0 ],
        ];
        for (List<int> dir in directions) {
          var i = 1;
          for (;;) {
            var newRow = coords.x + i * dir[0];
            var newCol = coords.y + i * dir[1];
            var newVector = Vector2(newRow, newCol);
            if (!isInBoard(newVector)) {
              break;
            }
            if (chessPieces[newRow][newCol] != null) {
              if (chessPieces[newRow][newCol]!.isPlayer1 != piece.isPlayer1) {
                candidateMoves.add(newVector);
              }
              break;
            }
            candidateMoves.add(newVector);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        debugPrint(ChessPieceType.king.toString());
        List<List<int>> directions = [
          [ -1, 0 ],
          [ 1, 0 ],
          [ 0, -1 ],
          [ 0, 1 ],
          [ -1, -1 ],
          [ -1, 1 ],
          [ 1, -1 ],
          [ 1, 1 ],
        ];
        for (List<int> dir in directions) {
            var newRow = coords.x + dir[0];
            var newCol = coords.y + dir[1];
            var newVector = Vector2(newRow, newCol);
            if (!isInBoard(newVector)) {
              continue;
            }
            if (chessPieces[newRow][newCol] != null) {
              if (chessPieces[newRow][newCol]!.isPlayer1 != piece.isPlayer1) {
                candidateMoves.add(newVector);
              }
              continue;
            }
            candidateMoves.add(newVector);
        }
        break;
      case ChessPieceType.pawn:
        debugPrint(ChessPieceType.pawn.toString());
        // pawns can move forward
        if (isInBoard(coords.addX(direction)) && chessPieces[coords.x + direction][coords.y] == null) {
          candidateMoves.add(coords.addX(direction));
        }
        // if pawn first move check two boxes is valid
        if ((coords.x == 1 && piece.isPlayer1) || (coords.x == 6 && !piece.isPlayer1)) {
          if (isInBoard(coords.addX((2 * direction))) && chessPieces[coords.x + (2 * direction)][coords.y] == null && chessPieces[coords.x + direction][coords.y] == null) {
            candidateMoves.add(coords.addX(2 * direction));
          }
        }
        // check is there any piece diagonally to kill 🔪 left side
        if (isInBoard(coords.addXY(direction, -1)) && chessPieces[coords.x + direction][coords.y - 1] != null && chessPieces[coords.x + direction][coords.y - 1]!.isPlayer1 != piece.isPlayer1) {
          candidateMoves.add(coords.addXY(direction, -1));
        }

        // check is there any piece diagonally to kill 🔪 right side
        if (isInBoard(coords.addXY(direction, 1)) && chessPieces[coords.x + direction][coords.y + 1] != null && chessPieces[coords.x + direction][coords.y + 1]!.isPlayer1 != piece.isPlayer1) {
          candidateMoves.add(coords.addXY(direction, 1));
        }
    }
    return candidateMoves;
  }

  void movePiece(Vector2 coords) {

    // if the new place has an enemy piece
    if(chessPieces[coords.x][coords.y] != null) {
      var capturedPiece = chessPieces[coords.x][coords.y];
      if(capturedPiece!.isPlayer1) {
        killedWhitePieces.add(capturedPiece);
      } else {
        killedBlackPieces.add(capturedPiece);
      }
    }

    chessPieces[coords.x][coords.y] = selectedPiece;
    chessPieces[selectedPiecePos.x][selectedPiecePos.y] = null;

    // see if any kings are under attack
    checkStatus = isKingInCheck(!isWhiteTrun) ? true : false;

    setState(() {
        selectedPiece = null;
        selectedPiecePos.x = -1;
        selectedPiecePos.y = -1;
        validMoves = [];
    });

    // change turns to player 2
    isWhiteTrun = !isWhiteTrun;

  }

  bool isKingInCheck(bool isWhiteKing) {
    List<int> kingPos = isWhiteKing ? whitekingPos : blackKingPos;
    
    // check if any enemy piece can attack the king
    for(int i = 0; i < 8; i++) {
      for( int j = 0; j < 8; j++) {
        if(chessPieces[i][j] == null || chessPieces[i][j]!.isPlayer1 == isWhiteKing) {
          continue;
        }

        List<Vector2> pieceValidMoves = calculateRawValidMoves(Vector2(i, j), chessPieces[i][j]);

        if(pieceValidMoves.any((move) => move.x == kingPos[0] && move.y == kingPos[1])) {
          return true;
        }
      }
    }

    return false;
  }

  void pieceSelected(Vector2 coords) {

    setState(() {      
      if(selectedPiece == null && chessPieces[coords.x][coords.y] != null) {
        if(chessPieces[coords.x][coords.y]!.isPlayer1 == isWhiteTrun) {
          selectedPiece = chessPieces[coords.x][coords.y];
          selectedPiecePos = coords;
        }
      } else if(chessPieces[coords.x][coords.y] != null && chessPieces[coords.x][coords.y]!.isPlayer1 == selectedPiece!.isPlayer1) {
        selectedPiece = chessPieces[coords.x][coords.y];
        selectedPiecePos = coords;
      } else if(selectedPiece != null && validMoves.any((Vector2 element) => element.x == coords.x && element.y == coords.y)) {
        movePiece(coords);
      }
      // if a piece is selected, calculate valid moves
      validMoves = calculateRawValidMoves(selectedPiecePos, selectedPiece);
    });

  }
  
  @override
  Widget build(BuildContext context) {
    print(checkStatus ? "check" : "no check");
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: Chess.totalBoxes,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          int x = index ~/ Chess.boxes;
          int y = index % Chess.boxes;
          bool isOddBox = (x + y) % 2 == 0;

          bool isValidMove = false;
          for (var pos in validMoves) {
            if (pos.x == x && pos.y == y) {
              isValidMove = true;
            }
          }
          return GestureDetector(
              onTap: () {
                pieceSelected(Vector2(x, y));
              },
              child: widget.chessBoard.render(ChessBoardRenderParams(index: index, isOddBox: isOddBox, isSelected: selectedPiecePos.x == x && selectedPiecePos.y == y, chessPiece: chessPieces[x][y], isValidMove: isValidMove)));
        },
      ),
    );
  }
}
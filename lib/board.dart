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
  bool isWhiteTurn = true;

  // initial position of king
  Vector2 whitekingPos = Vector2.init();
  Vector2 blackKingPos = Vector2.init();
  bool checkStatus = false;


  @override
  void initState() {
    super.initState();
    _intializeBoard();
  }

  List<Vector2> validMoves = [];

  bool isInBoard(Vector2 coords) => (coords.x >= 0 && coords.x < 8) && (coords.y >= 0 && coords.y < 8);

  void _intializeBoard() {
    chessPieces = ChessPiece.generateChessPiece(widget.chessPieces);
    checkStatus = false;
    killedWhitePieces.clear();
    killedBlackPieces.clear();
    resetKingPos();
    setState(() {
      
    });
  }

  // Calculate raw valid moves
  List<Vector2> calculateRawValidMoves(Vector2 coords, ChessPieceData? piece) {
    List<Vector2> candidateMoves = [];
    if(piece == null) {
      return candidateMoves;
    }
    int direction = piece.isPlayer1 ? 1 : -1;
    
    switch (piece.type) {
      case ChessPieceType.rook:
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

  List<Vector2> calculateValidMoves(Vector2 pos, ChessPieceData? piece, bool checkSimulation) {
    List<Vector2> validMoves = [];
    List<Vector2> candidateMoves = calculateRawValidMoves(pos, piece);

    if(checkSimulation) {
      for(var move in candidateMoves) {
        if(piece != null && simulationMoveSafe(piece, pos, move)) {
          validMoves.add(move);
        }
      }
    } else {
      validMoves = candidateMoves;
    }
    return validMoves;
  }

  bool simulationMoveSafe(ChessPieceData piece, Vector2 startPos, Vector2 endPos) {
    // Save the current board state
    ChessPieceData? originalDestinationPiece = chessPieces[endPos.x][endPos.y];

    // if the piece is the king, save it's current position and update
    Vector2? originalKingPos;
    if(piece.type == ChessPieceType.king) {
      originalKingPos = piece.isPlayer1 ? whitekingPos : blackKingPos;

      // update the king position
      if(piece.isPlayer1) {
        whitekingPos = endPos;
      } else {
        blackKingPos = endPos;
      }
    }

    // Simulate the move
    chessPieces[endPos.x][endPos.y] = piece;
    chessPieces[startPos.x][startPos.y] = null;

    // Check if king under attack
    bool kingInCheck = isKingInCheck(piece.isPlayer1);

    // restore board to original state
    chessPieces[startPos.x][startPos.y] = piece;
    chessPieces[endPos.x][endPos.y] = originalDestinationPiece;

    // If the piece was the king, restore it original position
    if(piece.type == ChessPieceType.king && originalKingPos != null) {
      if(piece.isPlayer1) {
        whitekingPos = originalKingPos;
      } else {
        blackKingPos = originalKingPos;
      }
    }
    // if king is in check = true, means it's not a safe move. safe move = false
    return !kingInCheck;

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

    if(selectedPiece!.type == ChessPieceType.king) {
      if(selectedPiece!.isPlayer1) {
        whitekingPos = coords.copyWith();
      } else {
        blackKingPos = coords.copyWith();
      }
    }

    // see if any kings are under attack
    checkStatus = isKingInCheck(!isWhiteTurn) ? true : false;

    setState(() {
        selectedPiece = null;
        selectedPiecePos.x = -1;
        selectedPiecePos.y = -1;
        validMoves = [];
    });

    // check if it's check mate
    if(isCheckMate(!isWhiteTurn)) {
      showDialog(context: context, builder: (context) => 
        AlertDialog(title: const Text("Check mate"), 
        actions: [
          TextButton(onPressed: resetGame, child: const Text("Play again"))],));
    }

    // change turns to player 2
    isWhiteTurn = !isWhiteTurn;

  }

  void resetGame() {
    Navigator.pop(context);
    _intializeBoard();
  }

  void resetKingPos() {
    whitekingPos = Vector2(0, 4);
    blackKingPos = Vector2(7, 4);
    isWhiteTurn = true;
  }

  bool isKingInCheck(bool isWhiteKing) {
    Vector2 kingPos = isWhiteKing ? whitekingPos : blackKingPos;
    // check if any enemy piece can attack the king
    for(int i = 0; i < 8; i++) {
      for( int j = 0; j < 8; j++) {
        if(chessPieces[i][j] == null || chessPieces[i][j]!.isPlayer1 == isWhiteKing) {
          continue;
        }

        List<Vector2> pieceValidMoves = calculateValidMoves(Vector2(i, j), chessPieces[i][j], false);
        if(pieceValidMoves.any((move) => move.x == kingPos.x && move.y == kingPos.y)) {
          return true;
        }
      }
    }

    return false;
  }

  void pieceSelected(Vector2 coords) {

    setState(() {      
      if(selectedPiece == null && chessPieces[coords.x][coords.y] != null) {
        if(chessPieces[coords.x][coords.y]!.isPlayer1 == isWhiteTurn) {
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
      validMoves = calculateValidMoves(selectedPiecePos, selectedPiece, true);
    });

  }
  
  bool isCheckMate(bool isWhiteKing) {
    // if the king is not in check, then it's not checkmate
    if(!isKingInCheck(isWhiteKing)) {
      return false;
    }

    // if there is at least one legal move for any of the player's pieces, then it's not checkmate
    for(int i = 0; i < 8; i++) {
      for(int j = 0; j< 8; j++) {
        // Skip empty squares and pieces of the other color
        if(chessPieces[i][j] == null || chessPieces[i][j]!.isPlayer1 != isWhiteKing) {
          continue;
        }

        List<Vector2> pieceValidMoves = calculateValidMoves(Vector2(i, j), chessPieces[i][j], true);

        // if this piece has any valid moves, then it's not checkmate
        if(pieceValidMoves.isNotEmpty) {
          return false;
        }
      }
    }
    // if none of the above conditions are met, then there is no legal moves left to make
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
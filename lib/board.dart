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
  @override
  void initState() {
    super.initState();
    chessPieces = ChessPiece.generateChessPiece(widget.chessPieces);
  }

  List<Vector2> validMoves = [];

  bool isInBoard(Vector2 coords) => (coords.x >= 0 && coords.x < 8) && (coords.y >= 0 && coords.y < 8);

  // Calculate raw valid moves
  List<Vector2> calculateRawValidMoves(Vector2 coords, ChessPieceData piece) {
    List<Vector2> candidateMoves = [];
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
        if (isInBoard(coords.addXY(direction, -1)) && chessPieces[coords.x + direction][coords.y - 1] != null && chessPieces[coords.x + direction][coords.y - 1]!.isPlayer1) {
          candidateMoves.add(coords.addXY(direction, -1));
        }

        // check is there any piece diagonally to kill 🔪 right side
        if (isInBoard(coords.addXY(direction, 1)) && chessPieces[coords.x + direction][coords.y + 1] != null && chessPieces[coords.x + direction][coords.y + 1]!.isPlayer1) {
          candidateMoves.add(coords.addXY(direction, 1));
        }
    }
    
    return candidateMoves;
  }

  void movePiece(Vector2 coords) {
    chessPieces[coords.x][coords.y] = selectedPiece;
    chessPieces[selectedPiecePos.x][selectedPiecePos.y] = null;

    setState(() {
        selectedPiece = null;
        selectedPiecePos.x = -1;
        selectedPiecePos.y = -1;
        validMoves = [];
    });
  }

  void pieceSelected(Vector2 coords) {
    setState(() {
      if(chessPieces[coords.x][coords.y] != null) {
        selectedPiece = chessPieces[coords.x][coords.y];
        selectedPiecePos = coords;
      } else if(selectedPiece != null && validMoves.any((Vector2 element) => element.x == coords.x && element.y == coords.y)) {
        movePiece(coords);
      }
      // if a piece is selected, calculate valid moves
      validMoves = calculateRawValidMoves(selectedPiecePos, chessPieces[coords.x][coords.y]!);
    });
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
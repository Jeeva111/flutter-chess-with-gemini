import 'package:chess/boards/chess_board.dart';
import 'package:chess/pieces/chess_piece.dart';
import 'package:chess/const.dart';
import 'package:flutter/material.dart';

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
  ({
    int x,
    int y
  }) selectedPiece = (
    x: -1,
    y: -1
  );
  @override
  void initState() {
    super.initState();
    chessPieces = ChessPiece.generateChessPiece(widget.chessPieces);
  }

  void generateChessPieces() {}

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
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPiece = (
                    x: x,
                    y: y
                  );
                });
              },
              child: widget.chessBoard.render(ChessBoardRenderParams(index: index, isOddBox: isOddBox, isSelected: selectedPiece.x == x && selectedPiece.y == y, chessPiece: chessPieces[x][y])));
        },
      ),
    );
  }
}

bool indexExists(List<List<dynamic>> arr, int row, int col) {
  // Check if the row index is within bounds
  if (row < 0 || row >= arr.length) {
    return false;
  }
  // Check if the column index is within bounds
  if (col < 0 || col >= arr[row].length) {
    return false;
  }
  // Both row and column indices are within bounds
  return true;
}

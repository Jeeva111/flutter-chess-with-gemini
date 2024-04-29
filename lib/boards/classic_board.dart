import 'package:chess/boards/chess_board.dart';
import 'package:flutter/material.dart';

class ClassicBoard implements ChessBoard {
  const ClassicBoard();

  @override
  Widget render(ChessBoardRenderParams params) {
    Color currBoxColor = params.isSelected ? boxColor.selectedColor : (params.isOddBox ? boxColor.box1 : boxColor.box2);
    return ColoredBox(
      color: currBoxColor,
      child: drawChessPiece(params.chessPiece?.icon, params.chessPiece?.color),
    );
  }

  @override
  ({
    Color box1,
    Color box2,
    Color selectedColor
  }) get boxColor => (
        box1: Colors.blueGrey,
        box2: Colors.blueAccent,
        selectedColor: Colors.yellow
      );
}

import 'package:chess/boards/chess_board.dart';
import 'package:flutter/material.dart';

class ClassicBoard implements ChessBoard {
  const ClassicBoard();

  @override
  Widget render(ChessBoardRenderParams params) {
    Color currBoxColor = (params.isOddBox ? boxColor.box1 : boxColor.box2);
    if (params.isSelected) {
      currBoxColor = boxColor.selectedColor;
    } else if (params.isValidMove) {
      currBoxColor = Colors.greenAccent;
    }
    return Container(
      decoration: BoxDecoration(border: const Border(right: BorderSide(color: Colors.black), bottom: BorderSide(color: Colors.black)), color: currBoxColor),
      child: drawChessPiece(params.chessPiece?.icon, params.chessPiece?.color),
    );
  }

  @override
  ({
    Color box1,
    Color box2,
    Color selectedColor
  }) get boxColor => (
        box1: Colors.black54,
        box2: Colors.lightBlue,
        selectedColor: Colors.green
      );
}

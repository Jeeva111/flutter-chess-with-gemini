import 'package:chess/boards/chess_board.dart';
import 'package:flutter/material.dart';

class ClassicBoard implements ChessBoard {
  const ClassicBoard();

  @override
  Widget render(ChessBoardRenderParams params) {
    Color currBoxColor = (params.isOddBox ? boxColor.box1 ?? Colors.white : boxColor.box2 ?? Colors.black);
    Color borderColor = currBoxColor;
    if (params.isSelected) {
      currBoxColor = boxColor.selectedColor ?? Colors.red;
    } else if (params.isValidMove) {
      currBoxColor = Colors.greenAccent;
    }
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor,width: 3), color: currBoxColor),
      child: drawChessPiece(params.chessPiece?.icon, params.chessPiece?.color),
    );
  }

  @override
  ({
    Color? box1,
    Color? box2,
    Color? selectedColor
  }) get boxColor => (
        box1: Colors.grey[400],
        box2: Colors.grey[600],
        selectedColor: Colors.green
      );
}

import 'package:chess/component/chess_piece.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class ChessBoard {
  abstract final ({
    Color color1,
    Color color2
  }) boxColor;
  const ChessBoard();
  Widget render({required int index, required bool isColor1, required bool isSelected, ChessPieceData? chessPiece});
}

class ClassicBoard implements ChessBoard {
  const ClassicBoard();

  @override
  Widget render({required int index, required bool isColor1, required bool isSelected, ChessPieceData? chessPiece}) {
    return ColoredBox(
      color: isColor1 ? boxColor.color1 : boxColor.color2,
      child: drawChessPiece(chessPiece?.icon),
    );
  }

  @override
  ({
    Color color1,
    Color color2
  }) get boxColor => (
        color1: Colors.white,
        color2: Colors.black
      );
}

Widget? drawChessPiece(String? svgImagePath, [Color color = Colors.pink]) {
  if (svgImagePath != null) {
    return SvgPicture.asset(svgImagePath, colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
  return null;
}

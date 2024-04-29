import 'package:chess/pieces/chess_piece.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

interface class ChessBoardRenderParams {
  final int index;
  final bool isOddBox;
  final bool isSelected;
  final ChessPieceData? chessPiece;
  const ChessBoardRenderParams({
    required this.index,
    required this.isOddBox,
    required this.isSelected,
    this.chessPiece,
  });
}

abstract class ChessBoard {
  abstract final ({
    Color box1,
    Color box2,
    Color selectedColor
  }) boxColor;
  const ChessBoard();
  Widget render(ChessBoardRenderParams params);
}

Widget? drawChessPiece(String? svgImagePath, Color? color) {
  if (svgImagePath != null) {
    return SvgPicture.asset(svgImagePath, colorFilter: ColorFilter.mode(color ?? Colors.pink, BlendMode.srcIn));
  }
  return null;
}

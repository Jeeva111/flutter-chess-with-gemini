import 'package:flutter/material.dart';

class ClassicChessPiece implements ChessPieceTemplate {
  @override
  // Black and white piece
  (
    Color,
    Color
  ) get colors => (
        Colors.white,
        Colors.black
      );

  @override
  ChessPieceData get bishop => (
        type: ChessPieceType.bishop,
        icon: "assets/piece/sample.svg"
      );

  @override
  ChessPieceData get king => (
        type: ChessPieceType.king,
        icon: "assets/piece/sample.svg"
      );

  @override
  ChessPieceData get knight => (
        type: ChessPieceType.knight,
        icon: "assets/piece/sample.svg"
      );

  @override
  ChessPieceData get pawn => (
        type: ChessPieceType.pawn,
        icon: "assets/piece/sample.svg"
      );

  @override
  ChessPieceData get queen => (
        type: ChessPieceType.queen,
        icon: "assets/piece/sample.svg"
      );

  @override
  ChessPieceData get rook => (
        type: ChessPieceType.rook,
        icon: "assets/piece/sample.svg"
      );
  const ClassicChessPiece();
}

typedef ChessPieceData = ({
  ChessPieceType type,
  String icon
});

abstract class ChessPieceTemplate {
  final (
    Color color1,
    Color color2
  ) colors;
  final ChessPieceData pawn;
  final ChessPieceData rook;
  final ChessPieceData knight;
  final ChessPieceData bishop;
  final ChessPieceData queen;
  final ChessPieceData king;
  const ChessPieceTemplate({
    required this.pawn,
    required this.rook,
    required this.knight,
    required this.bishop,
    required this.queen,
    required this.king,
    required this.colors,
  });
}

enum ChessPieceType {
  pawn,
  rook,
  knight,
  bishop,
  queen,
  king;
}

class ChessPiece {
  const ChessPiece();
}

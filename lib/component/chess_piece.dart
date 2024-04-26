import 'package:flutter/material.dart';

class ClassicChessPiece extends ChessPieceTemplate {
  const ClassicChessPiece();
  @override
  final ChessPieceData bishop = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.bishop
  );

  @override
  final (
    Color,
    Color
  ) colors = (
    Colors.white,
    Colors.black
  );

  @override
  final ChessPieceData king = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.king
  );

  @override
  final ChessPieceData knight = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.knight
  );

  @override
  final ChessPieceData pawn = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.pawn
  );

  @override
  final ChessPieceData queen = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.queen
  );

  @override
  final ChessPieceData rook = (
    icon: "assets/chess/piece/sample.svg",
    type: ChessPieceType.rook
  );
}

typedef ChessPieceData = ({
  ChessPieceType type,
  String icon
});

abstract class ChessPieceTemplate {
  abstract final (
    Color color1,
    Color color2
  ) colors;
  abstract final ChessPieceData pawn;
  abstract final ChessPieceData rook;
  abstract final ChessPieceData knight;
  abstract final ChessPieceData bishop;
  abstract final ChessPieceData queen;
  abstract final ChessPieceData king;
  const ChessPieceTemplate();
  List<List<ChessPieceData>> generateChessPiece() {
    return [];
  }
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
  static void generateChessPiece(ChessPieceTemplate template) {
    List<List<ChessPieceData>> list = [];
  }
}

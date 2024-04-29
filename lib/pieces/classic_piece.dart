import 'package:chess/pieces/chess_piece.dart';
import 'package:flutter/material.dart';

class ClassicChessPiece extends ChessPieceTemplate {
  @override
  final (
    Color,
    Color
  ) colors = (
    Colors.white,
    Colors.black
  );

  @override
  final ChessPieceData bishop = ChessPieceData(icon: "assets/chess/pieces/bishop-w.svg", type: ChessPieceType.bishop, firstLetter: 'B');

  @override
  final ChessPieceData king = ChessPieceData(icon: "assets/chess/pieces/king-w.svg", type: ChessPieceType.king, firstLetter: 'K');

  @override
  final ChessPieceData knight = ChessPieceData(icon: "assets/chess/pieces/knight-w.svg", type: ChessPieceType.knight, firstLetter: 'N');

  @override
  final ChessPieceData pawn = ChessPieceData(icon: "assets/chess/pieces/pawn-w.svg", type: ChessPieceType.pawn, firstLetter: 'P');

  @override
  final ChessPieceData queen = ChessPieceData(icon: "assets/chess/pieces/queen-w.svg", type: ChessPieceType.queen, firstLetter: 'Q');

  @override
  final ChessPieceData rook = ChessPieceData(icon: "assets/chess/pieces/rook-w.svg", type: ChessPieceType.rook, firstLetter: 'R');
}

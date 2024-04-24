import 'package:chess/board.dart';
import 'package:chess/component/chess_board.dart';
import 'package:chess/component/chess_piece.dart';
import 'package:chess/const.dart';
import 'package:flutter/material.dart';

const ChessBoard classicBoard = ClassicBoard();
const ChessPieceTemplate classicChessPiece = ClassicChessPiece();

class ChessGame extends StatelessWidget {
  const ChessGame({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Chess.backgroundColor,
        body: Center(
            child: RenderBoard(
          chessBoard: classicBoard,
          chessPieces: classicChessPiece,
        )));
  }
}

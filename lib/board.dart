import 'package:chess/component/chess_box.dart';
import 'package:chess/const.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  final int index;
  const ChessBoard({super.key, required this.index});

  bool get isWhite {
    int x = index ~/ Chess.boxes;
    int y = index % Chess.boxes;
    return (x + y) % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    return isWhite ? const WhiteBox() : const BlackBox();
  }
}

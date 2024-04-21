import 'package:chess/board.dart';
import 'package:chess/const.dart';
import 'package:flutter/material.dart';

class ChessGame extends StatelessWidget {
  const ChessGame({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Chess.backgroundColor,
        body: Center(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 8 * 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (context, index) {
              return ChessBoard(
                index: index,
              );
            },
          ),
        ));
  }
}

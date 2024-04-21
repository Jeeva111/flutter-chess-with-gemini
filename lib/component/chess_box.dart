import 'package:flutter/material.dart';

abstract class ChessBox extends StatelessWidget {
  const ChessBox({super.key});
}

class WhiteBox extends ChessBox {
  const WhiteBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.white);
  }
}

class BlackBox extends ChessBox {
  const BlackBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.grey);
  }
}

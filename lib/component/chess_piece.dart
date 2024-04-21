import 'package:chess/const.dart';

abstract class ChessPiece {
  final ChessPieceType type;
  final bool isWhite;
  final String imagePath;

  const ChessPiece({required this.type, required this.isWhite, required this.imagePath});
}

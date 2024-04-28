import 'package:chess/const.dart';
import 'package:flutter/material.dart';

typedef ChessPieceData = ({
  ChessPieceType type,
  String icon,
  String firstLetter,
});

typedef ListOfChessPieces = List<List<ChessPieceData?>>;

// Bb4+ => Bishop x-axis moves to b and y-axis moves to 4 plus means check
// Qxg4 => Queen x means kill other are x and y axis
// O-O => switch king and rook moves besides
// dxe5 => pawn kills another pawn from x-axis "d" x means kill moved to x-y axis e5
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

  List<ChessPieceData> listOfPieces() {
    return [
      rook,
      knight,
      bishop,
      queen,
      king,
      bishop,
      knight,
      rook
    ];
  }
}

enum ChessPieceType {
  rook,
  knight,
  bishop,
  queen,
  king,
  pawn,
}

class ClassicChessPiece extends ChessPieceTemplate {
  const ClassicChessPiece();

  @override
  final (
    Color,
    Color
  ) colors = (
    Colors.white,
    Colors.black
  );

  @override
  final ChessPieceData bishop = (
    icon: "assets/chess/pieces/bishop-w.svg",
    type: ChessPieceType.bishop,
    firstLetter: 'B'
  );

  @override
  final ChessPieceData king = (
    icon: "assets/chess/pieces/king-w.svg",
    type: ChessPieceType.king,
    firstLetter: 'K'
  );

  @override
  final ChessPieceData knight = (
    icon: "assets/chess/pieces/knight-w.svg",
    type: ChessPieceType.knight,
    firstLetter: 'N'
  );

  @override
  final ChessPieceData pawn = (
    icon: "assets/chess/pieces/pawn-w.svg",
    type: ChessPieceType.pawn,
    firstLetter: 'P'
  );

  @override
  final ChessPieceData queen = (
    icon: "assets/chess/pieces/queen-w.svg",
    type: ChessPieceType.queen,
    firstLetter: 'Q'
  );

  @override
  final ChessPieceData rook = (
    icon: "assets/chess/pieces/rook-w.svg",
    type: ChessPieceType.rook,
    firstLetter: 'R'
  );
}

class ChessPiece {
  static ListOfChessPieces generateChessPiece(ChessPieceTemplate pieces) {
    // Creating spaces in array 8 * 8
    ListOfChessPieces listOfChessPieces = List.generate(Chess.boxes, (x) => List.generate(Chess.boxes, (y) => null));

    // Generate Player 1 pieces
    // Spawn chess pieces
    var listOfPieces = pieces.listOfPieces();
    for (var i = 0; i < listOfPieces.length; i++) {
      listOfChessPieces[0][i] = listOfPieces[i];
    }

    // Position for pawn
    for (int i = 0; i < Chess.boxes; i++) {
      listOfChessPieces[1][i] = pieces.pawn;
    }

    listOfChessPieces[Chess.boxes - 1] = List.from(listOfChessPieces[0]);
    listOfChessPieces[Chess.boxes - 2] = List.from(listOfChessPieces[1]);
    return listOfChessPieces;
  }
}

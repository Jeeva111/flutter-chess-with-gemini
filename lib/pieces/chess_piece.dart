import 'package:chess/component/vector2.dart';
import 'package:chess/const.dart';
import 'package:flutter/material.dart';

class ChessPieceData {
  final ChessPieceType type;
  final String icon;
  final String firstLetter;
  Color? color;
  bool isPlayer1;
  ChessPieceData({required this.type, required this.icon, required this.firstLetter, this.color = Colors.pink, this.isPlayer1 = true});

  @override
  String toString() {
    return "type: $type, icon: $icon, firstLetter: $firstLetter, color: $color, isPlayer1: $isPlayer1";
  }

  ChessPieceData copyWith(Color color, [bool isPlayer1 = true]) => ChessPieceData(type: type, icon: icon, firstLetter: firstLetter, color: color, isPlayer1: isPlayer1);
}

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

class ChessPiece {

  static ListOfChessPieces generateChessPiece(ChessPieceTemplate pieces) {
    // Creating spaces in array 8 * 8
    ListOfChessPieces listOfChessPieces = List.generate(Chess.boxes, (x) => List.generate(Chess.boxes, (y) => null));

    // Generate Player 1 pieces
    // Spawn chess pieces
    var listOfPieces = pieces.listOfPieces();
    for (var i = 0; i < listOfPieces.length; i++) {
      ChessPieceData player1 = listOfPieces[i].copyWith(pieces.colors.$1);
      listOfChessPieces[0][i] = player1;
      ChessPieceData player2 = listOfPieces[i].copyWith(pieces.colors.$2, false);
      listOfChessPieces[7][i] = player2;
    }

    // Position for pawn
    for (int i = 0; i < Chess.boxes; i++) {
      ChessPieceData player1 = pieces.pawn.copyWith(pieces.colors.$1);
      listOfChessPieces[1][i] = player1;
      ChessPieceData player2 = pieces.pawn.copyWith(pieces.colors.$2, false);
      listOfChessPieces[6][i] = player2;
    }
    return listOfChessPieces;
  }
  
  static ({Vector2 start, Vector2 move})? commandToMove(
    String command // "Nb0a2" equals to bishop x = 1 and y = 4
  ) {
      SplitData? splitCommand = moveCommandSplitData(command);
      if(splitCommand is SplitData) {
        return (start: splitCommand.startPos, move: splitCommand.movePos);
      }
      return null;
  }

  static SplitData? moveCommandSplitData(String move) {
    SplitData? data;
    if(move.length < 5 || move.isEmpty) {
      return null;
    }
    List<String> split = move.split("");
    if(split.length == 5) {
      return SplitData(pieceName: split[0], startPos: Vector2(int.parse(split[2]), charToInt(split[1])), movePos: Vector2(int.parse(split[4]), charToInt(split[3])));
    }
    return data;
  }
}

interface class SplitData {
  final String pieceName;
  final Vector2 startPos;
  final Vector2 movePos;
  const SplitData({
    required this.pieceName,
    required this.startPos,
    required this.movePos
  });

  @override
  String toString() => "$pieceName, start: $startPos, move: $movePos";
    
}

int charToInt(String char) => char.codeUnitAt(0) - 'a'.codeUnitAt(0);

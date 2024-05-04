class Vector2 {
  int x;
  int y;

  Vector2(this.x, this.y);

  factory Vector2.init() => Vector2(-1, -1);

  @override
  String toString() => "($x, $y)";

  Vector2 copyWith() => Vector2(x, y);

  Vector2 addX(int x) => Vector2(this.x + x, y);

  Vector2 addY(int y) => Vector2(x, this.y + y);

  Vector2 addXY(int x, int y) => Vector2(this.x + x, this.y + y);
}

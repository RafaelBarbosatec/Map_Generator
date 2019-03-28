
import 'dart:math';

import 'package:map_generator/Map.dart';
import 'package:map_generator/Pencil.dart';

class NextTile{
  Tile up;
  Tile right;
  Tile bottom;
  Tile left;
}

class Tile{

  int index;
  int x;
  int y;
  NextTile next;
  bool isLand;
  double size;
  Pencil pencil;
  Dim tileDim;

  Tile(this.index, this.x, this.y, this.next, this.isLand, this.size){
    pencil = new Pencil(this);
  }

  List<Tile> surrounds({spread = 5, randomize = false}){
    return _check(this,spread,randomize: randomize);
  }

  List<Tile> _check(Tile tile, int distance, {bool randomize = false}){

    List<Tile> checked = List();
    checked.add(tile);
    var lDistance = distance;
    if( randomize ) lDistance = ((lDistance - 0.5) + Random().nextDouble()).floor();

    if( lDistance > 0 ){
      lDistance -= 1;
      if(tile.next.up != null) checked.addAll(_check(tile.next.up, lDistance));
      if(tile.next.right != null) checked.addAll(_check(tile.next.right, lDistance));
      if(tile.next.bottom != null) checked.addAll(_check(tile.next.bottom, lDistance));
      if(tile.next.left != null) checked.addAll(_check(tile.next.left, lDistance));
    }

    return checked;

  }

  @override
  String toString() {
    return 'Tile{index x: $x, y: $y, isLand: $isLand, next: $next}';
  }


}
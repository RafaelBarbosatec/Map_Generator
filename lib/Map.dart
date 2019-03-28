import 'dart:math';
import 'package:map_generator/Tile.dart';


class Dim{
  int x;
  int y;
}
class MyMap{

  MyMap(this.width, this.height);

  int width;
  int height;

  Dim tileDim;
  List<Tile> _mapList;

  Future generateBase() async{

    _mapList = List();
    var totalTiles  = width * height;
    int x = 0;
    int y = 0;

    while(_mapList.length < totalTiles){
      var index = _mapList.length;
      var current = Tile(
          index,
          x,
          y,
          NextTile(),
          Random().nextDouble() < 0.5,
          2
      );

      addLinks(current);

      _mapList.add(
          current
      );

      if( x == (width - 1) ) {
        x = 0;
        if( y == (height - 1) ) { y = 0; } else { y++; }
      } else {
        x++;
      }
    }

    //generateLlinks();
  }

  List<Tile> getList(){
    return _mapList;
  }

  void addLinks(Tile current) {
    int y = current.y;
    int x = current.x;
    if(y > 0){
      var yL = (y-1) * width;
      current.next.up = _mapList[yL+x];
      _mapList[yL+x].next.bottom = current;
    }

    if(x > 0){
      var yL = y * width;
      current.next.left = _mapList[yL+(x-1)];
      _mapList[yL+(x-1)].next.right = current;
    }
  }

}
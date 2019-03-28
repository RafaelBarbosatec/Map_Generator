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
    var totalTiles  = width *height;
    int x = 0;
    int y = 0;

    while(_mapList.length < totalTiles){
      var index = _mapList.length;
      _mapList.add(
        Tile(
            index,
            x,
            y,
            NextTile(),
            Random().nextDouble() < 0.5,
            2
        )
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

  void generateLlinks(){
    if(_mapList != null){
      _mapList.forEach((tile){
        if(tile.y > 0) tile.next.up = _mapList.firstWhere((t)=> t.x == tile.x && t.y == tile.y - 1);
        if(tile.x < width - 1) tile.next.right = _mapList.firstWhere((t)=> t.x == (tile.x + 1) && t.y == tile.y);
        if(tile.y < height - 1) tile.next.bottom =  _mapList.firstWhere((t)=> t.x == tile.x && t.y == (tile.y + 1));
        if(tile.x > 0) tile.next.left =  _mapList.firstWhere((t)=> t.x == (tile.x -1) && t.y == tile.y);
      });
    }
  }

  List<Tile> getList(){
    return _mapList;
  }
}
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

  void startGenerator() async{
     await _generateBase();
     await _sinkBorders();
     await _smoothMaps(levels: 3);
    //await _genHeights();
  }

  Future _generateBase() async{

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
          2,
          width -1,
          height -1
      );

      _addLinks(current);

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

  Future _sinkBorders() async{

    _mapList.where((t)=> t.isLimit()).forEach((tile){
      tile.isLand = false;
      tile.surrounds(spread: 5, randomize: true).forEach((tile){
        tile.isLand = false;
      });
    });

  }

  void _addLinks(Tile current) {
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

  Future _smoothMaps({levels = 1}) async{

    while(levels > 0){

      _mapList.forEach((tile){
        var surrounds = tile.surrounds(spread: 2,randomize: true);
        var wallCount = surrounds.where((t) => t.isLand).length;
        if(wallCount > (surrounds.length / 2)) tile.isLand = true;
        if(wallCount < (surrounds.length / 2)) tile.isLand = false;
      });

      levels--;
    }
  }

  Future _genHeights() async {

    List<Tile> highTiles = List();
    List<Tile> landTiles = _mapList.where((t) => t.isLand).toList();
    int heightsPct = 2;
    int highTilesNumber = ( (landTiles.length/100).round() * heightsPct );

    for(var i = 0; i < highTilesNumber; i++){
      var tile = landTiles[ ( Random().nextDouble() * landTiles.length - 1 ).round() ];
      tile.height = (Random().nextDouble() * 1000).round();
      highTiles.add(tile);
    }

    highTiles.forEach((tile){

      tile.surrounds(spread: 7 + (Random().nextDouble() * 3).round(), randomize: true).forEach((tll){
        tll.height = ((tll.height + tile.height) / 2.2 + (Random().nextDouble())).round();
      });

      tile.surrounds(spread: 2 + (Random().nextDouble() * 3).round(), randomize: true).forEach((tll){
        tll.height = ((tll.height + tile.height) / 1.8 + (Random().nextDouble())).round();
      });

    });

  }

  List<Tile> getList(){
    return _mapList;
  }

}
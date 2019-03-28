import 'package:flutter/material.dart';
import 'package:map_generator/Tile.dart';

class Pencil{

  final Tile tile;
  var paint = new Paint();

  Pencil(this.tile);

  void draw(Canvas canvas,{double size}){
    double lSize = size == null ? tile.size : size;
    var path = new Path();
    if(tile.isLand){
      paint.color = Colors.brown;
    }else{
      paint.color = Colors.blue;
    }
    path.addRect(Rect.fromLTWH( tile.x * lSize,tile.y * lSize,lSize, lSize));
    canvas.drawPath(path, paint);
  }

}
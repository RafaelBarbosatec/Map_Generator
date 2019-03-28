import 'package:flutter/material.dart';
import 'package:map_generator/Map.dart';

class MapPainter extends CustomPainter {

  final MyMap map;

  MapPainter(this.map);

  @override
  void paint(Canvas canvas, Size size) {

    if(map.getList() != null){
      var Msize = size.width / map.width;
      map.getList().forEach((tile){
        tile.pencil.draw(canvas,size: Msize);
      });
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

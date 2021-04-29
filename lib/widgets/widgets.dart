import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int count;
  Badge(this.count);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      //color: Colors.green,
      child: Stack(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.yellow,
            size: 30,
          ),
          Positioned(
            right: 3,
            child: Container(
              child: Text(
                count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              padding: EdgeInsets.all(1),
              alignment: Alignment.center,
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(50)),
            ),
          )
        ],
      ),
    );
  }
}

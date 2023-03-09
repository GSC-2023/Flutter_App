import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeQuote extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 400,
      color: Colors.grey[200],
      child: GFCard(
        boxFit: BoxFit.cover,
        color: Colors.blue,
        title: GFListTile(
          title: Text(
            'Quote of the Day',
            style: TextStyle(color: Colors.white,)
            ),
        ),
        content: Text(
          "Take break is to walk longer\nConfusius wong yufei",
          style: TextStyle(color: Colors.white,)
          ),
      ),
    );
  }

}
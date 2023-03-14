import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeQuote extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 300,
      color: Colors.transparent,
      child: GFCard(
        boxFit: BoxFit.cover,
        color: White,
        title: GFListTile(
          title: Text(
            'Quote of the Day',
            style: TextStyle(color: Colors.black,)
            ),
        ),
        content: Text(
          "Take break is to walk longer\nConfusius wong yufei",
          style: TextStyle(color: Colors.black,)
          ),
      ),
    );
  }

}
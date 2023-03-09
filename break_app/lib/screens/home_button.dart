import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(children: [
          GFButton(
            onPressed: (){},
            text:"primary"
          ),
          GFButton(
            onPressed: (){},
            text:"primary"
          ),
        ],),
        Row(children: [
          GFButton(
          onPressed: (){},
          text:"primary"
        ),
        ],)
      ],
    );
  }

}
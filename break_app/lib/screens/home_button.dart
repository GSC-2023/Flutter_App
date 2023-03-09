import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 50, 40, 10),
      width: double.infinity,
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: 150,
              child: GFButton(
                onPressed: (){},
                text:"primary"
              ),
            ),
            Container(
              width: 150,
              child: GFButton(
                onPressed: (){},
                text:"primary"
              ),
            ),
          ],),
          Container(
            width: double.infinity,
            child: 
            GFButton(
            onPressed: (){},
            text:"primary"
          ),
          ),
        ],
      ),
    );
  }

}
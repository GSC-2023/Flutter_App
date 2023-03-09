import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/colors/colors.dart';

class HomeButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: 150,
              height: 40,
              child: GFButton(
                onPressed: (){},
                text:"primary",
                shape: GFButtonShape.pills,
              ),
            ),
            Container(
              width: 150,
              height: 40,
              child: GFButton(
                onPressed: (){},
                text:"primary",
                shape: GFButtonShape.pills,
              ),
            ),
          ],),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: 
              Container(
                height: 40,
                child: GFButton(
                onPressed: (){},
                text:"primary",
                shape: GFButtonShape.pills,
                ),
              ),
          ),
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/colors/colors.dart';

class HomeAuxilliaryButtons extends StatefulWidget {
  final VoidCallback restartTimer;
  final VoidCallback pauseTimer;

  HomeAuxilliaryButtons({Key? key, required this.restartTimer, required this.pauseTimer}) : super(key: key);

  @override
  _HomeAuxilliaryButtonsState createState() => _HomeAuxilliaryButtonsState();
}

class _HomeAuxilliaryButtonsState extends State<HomeAuxilliaryButtons>{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: 150,
              height: 45,
              child: GFButton(
                onPressed: (){},
                text:"Break Now",
                textColor: DarkGreen,
                shape: GFButtonShape.pills,
                color: White,
              ),
            ),
            Container(
              width: 150,
              height: 45,
              child: GFButton(
                onPressed: (){
                  widget.restartTimer();
                  widget.pauseTimer();
                },
                text:"Restart",
                textColor: DarkGreen,
                shape: GFButtonShape.pills,
                color: White,
              ),
            ),
          ],),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: 
              Container(
                height: 45,
                child: GFButton(
                onPressed: (){},
                text:"End Work",
                textColor: White,
                shape: GFButtonShape.pills,
                color: DarkGreen,
                ),
              ),
          ),
        ],
      ),
    );
  }

}
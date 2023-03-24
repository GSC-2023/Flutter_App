import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/colors/colors.dart';

class ExerciseButton extends StatefulWidget {
  final String name;
  ExerciseButton({required this.name});

  @override
  State<ExerciseButton> createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  late Map<String, dynamic> data;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/exercises.json');
    data = await json.decode(response);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(0.0, 10.0),
                blurRadius: 20.0)
          ]),
          child: GFImageOverlay(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            height: 5,
            width: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0), // Leave for dev purposes
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                        color: White,
                        fontSize: 30,
                        fontFamily: 'League Spartan'),
                  ),
                ],
              ),
            ),
            image: AssetImage('assets/icons/${widget.name}.png'),
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        onTap: () {
          Navigator.pushReplacementNamed(
              context, '/PhysicalActivities/ReliefExercises/Info',
              arguments: {
                'title': widget.name,
                'content': data[widget.name] as String,
              });
        },
      ),
      // child: TextButton(
      //   onPressed: () {
      //     Navigator.pushReplacementNamed(
      //       context,
      //       '/PhysicalActivities/ReliefExercises/Info',
      //       arguments: {
      //         'title': name,
      //         'content': //content is fixed for now
      //             '1. Bend your head forward and slightly to the right.\n2. With your right hand, gently pull your head downward. You\'ll feel a nice, easy stretch along the back left side of your neck.\n3. Hold for about 30 seconds.\n4. Repeat on the opposite side.',
      //       },
      //     );
      //   },
      //   child: Column(
      //     children: [
      //       Text(
      //         '${name}',
      //         style: TextStyle(fontSize: 30),
      //       ),
      //       Image.asset('assets/icons/${name}.png'),
      //     ],
      //   ),
      //   style: TextButton.styleFrom(
      //     backgroundColor: Colors.white,
      //     foregroundColor: Colors.green,
      //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      //   ),
      // ),
    );
  }
}

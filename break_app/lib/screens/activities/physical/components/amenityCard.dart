import 'package:flutter/material.dart';

class AmenityCard extends StatelessWidget {
  final name;
  final type;
  final duration;
  AmenityCard({required this.name, required this.type, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/icons/${type}.png'),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(name),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(duration),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

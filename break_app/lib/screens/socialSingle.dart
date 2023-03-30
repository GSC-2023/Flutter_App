import 'dart:developer';
import 'package:break_app/colors/colors.dart';
import 'package:break_app/firebase/database.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../models/profile.dart';
import './social.dart';

class SocialSingle extends StatefulWidget {
  SocialSingle(
      {super.key,
      required this.user,
      required this.users,
      required this.deleteFriend,
      required this.addFriend,
      this.add = false});
  final Function deleteFriend;
  final Function addFriend;
  final PhotoItem users;
  final profile user;
  bool add;

  @override
  State<SocialSingle> createState() => _SocialSingleState();
}

class _SocialSingleState extends State<SocialSingle> {
  late int breakTgt;
  late int streak;
  bool loading = true;
  Future _loadData() async {
    var bu = await DatabaseService().getUserWithName(widget.users.name);
    var meetings = bu!.meetups[widget.user.name] as List<dynamic>;
    if (meetings != null) {
      breakTgt = meetings.length;
    } else {
      breakTgt = 0;
    }
    inspect(bu.meetups[widget.user.name]);
    streak = breakTgt;
    print('init');
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
          ),
          backgroundColor: Color(0xECEAEA),
          shadowColor: Color(0xECEAEA),
          surfaceTintColor: Color(0xECEAEA),
          foregroundColor: Color(0xECEAEA),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(children: [
            loading
                ? Column(children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 200,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: LightBlue,
                          size: 75.0,
                        ),
                      ),
                    ),
                  ])
                : Container(
                    margin: EdgeInsetsDirectional.symmetric(
                        vertical: 10, horizontal: 0),
                    child: Column(
                      children: [
                        //USERNAME
                        Container(
                            margin: EdgeInsetsDirectional.only(top: 15),
                            child: Text(
                              toBeginningOfSentenceCase(widget.users.name)!,
                              style: TextStyle(
                                fontSize: 30,
                                // fontFamily:
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        //USER IMAGE
                        Container(
                          margin:
                              EdgeInsetsDirectional.only(top: 30, bottom: 20),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Colors.transparent,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ],
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                              image: NetworkImage(widget.users.image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        //STATISTICS
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(vertical: 10),
                          child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 90,
                                  width: 150,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Breaks Together',
                                        style: TextStyle(
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '$breakTgt',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 90,
                                  width: 150,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Streak',
                                        style: TextStyle(
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '$streak',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),

                        //SOCIAL BUTTONS
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 30),
                          child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Social');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 27, 115, 97),
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      'Go Back',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      widget.add
                                          ? await widget
                                              .addFriend(widget.users.name)
                                          : await widget
                                              .deleteFriend(widget.users.name);
                                      Navigator.pushNamed(context, '/Social');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 27, 115, 97),
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      widget.add
                                          ? 'Add Friend'
                                          : 'Remove Friend',
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ))
          ]),
        ));
  }
}

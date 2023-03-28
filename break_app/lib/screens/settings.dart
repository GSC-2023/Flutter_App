import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:provider/provider.dart';
import 'package:break_app/models/profile.dart';
import 'package:break_app/models/breakUser.dart';
import 'package:break_app/firebase/database.dart';


class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _currentSliderValue = 45;
  DateTime _lunchTime = DateTime(2017, 9, 7, 11, 00);
  DateTime _dinnerTime = DateTime(2017, 9, 9, 18, 00);
  double _cycleTime = 60;
  late String fileUrl;
  bool loading=true;

  late TextEditingController controller;
  late profile user;
  late breakUser bu;

  // var bu;

  Future<ListResult> _loadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref().list();
    return result;
  }

  Future searchFriend() async {

    final ListResult result = await _loadImages();
    inspect(result);
    print(result);
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String url = await file.getDownloadURL();
      var friendName = file.fullPath.split('.')[0];
      if (bu.name == friendName) {
        fileUrl = url;
      }
    });

    setState(() {
      loading=false;
    });
  }



  Future<void> getBreakUser(user) async {
    bu = await DatabaseService().getUser(user.uid);


    String lunchTimeStr = bu.lunchTime.toString();
    String dinnerTimeStr = bu.dinnerTime.toString();
    String lthh = lunchTimeStr.substring(0, 2);
    String dthh = dinnerTimeStr.substring(0, 2);
    String ltmm = lunchTimeStr.substring(2, 4);
    String dtmm = dinnerTimeStr.substring(2, 4);

    DateTime lunch = DateTime(2022, 9, 7, int.parse(lthh), int.parse(ltmm));
    DateTime dinner = DateTime(2022, 9, 7, int.parse(dthh), int.parse(dtmm));



    setState(() {
      _lunchTime = lunch;
      _dinnerTime = dinner;
      _currentSliderValue = bu.workTime.toDouble();
      _cycleTime = bu.cycleTime.toDouble();
    });

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      user = Provider.of<profile>(context, listen: false);
      getBreakUser(user);
      searchFriend();
    });

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // user = Provider.of<profile>(context);
    // inspect(user);
    //getBreakUser(user!.name);

    void submit() {
      Navigator.of(context).pop(controller.text);
    }

    Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Desired Duration"),
            content: TextField(
                decoration: InputDecoration(
                    hintText: _cycleTime.toInt().toString() + " minutes"),
                controller: controller),
            actions: [TextButton(child: Text("Submit"), onPressed: submit)]));

    return loading? Container() : Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
          ),
          backgroundColor: Color(0xECEAEA),
          shadowColor: Color(0xECEAEA),
          surfaceTintColor: Color(0xECEAEA),
          foregroundColor: Color(0xECEAEA),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Container(
                          margin:
                              EdgeInsetsDirectional.only(top: 30, bottom: 20),
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Colors.transparent,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                              image: NetworkImage(fileUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(bu.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ]),
            ),
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text("Work Time",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Text(_currentSliderValue.toInt().toString() +
                                " mins")),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color(0xff2E593F),
                                  inactiveTrackColor:
                                      Color(0xff2E593F).withOpacity(0.5),
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: 10.0,
                                  thumbColor: Colors.blueAccent,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  value: _currentSliderValue,
                                  max: _cycleTime,
                                  divisions: _cycleTime.toInt(),
                                  activeColor: Color(0xff2E593F),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                )))
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text("Rest Time",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: Text(
                                        (_cycleTime - _currentSliderValue)
                                                .toInt()
                                                .toString() +
                                            " mins")),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(0),
                                    child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Color(0xff2E593F),
                                          inactiveTrackColor: Color(0xff2E593F)
                                              .withOpacity(0.5),
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          trackHeight: 10.0,
                                          thumbColor: Colors.blueAccent,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 12.0),
                                          overlayColor:
                                              Colors.red.withAlpha(32),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                        ),
                                        child: Slider(
                                          value:
                                              _cycleTime - _currentSliderValue,
                                          max: _cycleTime,
                                          divisions: _cycleTime.toInt(),
                                          activeColor: Color(0xff2E593F),
                                          onChanged: (double value) {
                                            setState(() {
                                              _currentSliderValue =
                                                  _cycleTime - value;
                                            });
                                          },
                                        )))
                              ],
                            ),
                          ],
                        ))
                  ],
                )),

            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                              child: Text("Cycle Time"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff2E593F),
                                  fixedSize: const Size(150, 30)),
                              onPressed: () async {
                                final cycleTime = await openDialog();
                                if (cycleTime == null) return;

                                setState(
                                    () => _cycleTime = double.parse(cycleTime));
                                setState(() =>
                                    _currentSliderValue = _cycleTime * 0.75);
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(_cycleTime.toString() + " minutes"))
                        ]),

                        // LUNCH ===========================
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff2E593F),
                                      fixedSize: const Size(150, 30)),
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onChanged: (time) {
                                      setState(() {
                                        _lunchTime = time;
                                      });
                                      // print('change $time');
                                    }, onConfirm: (time) {
                                      setState(() {
                                        _lunchTime = time;
                                      });
                                      // print('newtTime $_lunchTime');
                                    },
                                        currentTime: _lunchTime,
                                        locale: LocaleType.en);
                                  },
                                  child: Text(
                                    'Lunch Time',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Text(
                                    _lunchTime.toString().substring(11, 16)))
                          ],
                        ),

                        // END LUNCH==============================================

                        // DINNER==============================================
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff2E593F),
                                      fixedSize: const Size(150, 30)),
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onChanged: (time) {
                                      setState(() {
                                        _dinnerTime = time;
                                      });
                                      _dinnerTime = time;
                                      // print('change $time');
                                    }, onConfirm: (time) {
                                      setState(() {
                                        _dinnerTime = time;
                                      });
                                      // print('confirm $time');
                                    },
                                        currentTime: _dinnerTime,
                                        locale: LocaleType.en);
                                  },
                                  child: Text(
                                    'Dinner Time',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Text(
                                    _dinnerTime.toString().substring(11, 16)))
                          ],
                        ),

                        // END DINNERRRR ====================================
                      ],
                    ))
              ],
            ),

            //   )
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff2E593F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size(350, 30),
                  ),
                  onPressed: () async {
                    bu.cycleTime = _cycleTime.toInt();
                    bu.workTime = _currentSliderValue.toInt();
                    bu.restTime = (_cycleTime - _currentSliderValue).toInt();
                    int lunchH = _lunchTime.hour;
                    int lunchM = _lunchTime.minute;
                    int dinnerH = _dinnerTime.hour;
                    int dinnerM = _dinnerTime.minute;
                    bu.lunchTime = (lunchH * 100 + lunchM).toInt();
                    bu.dinnerTime = (dinnerH * 100 + dinnerM).toInt();

                    await DatabaseService().updateUser(bu, user.uid);

                    final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Successfully Saved!"),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {},
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text("Save Changes")),
            )
          ],
        ));
  }
}

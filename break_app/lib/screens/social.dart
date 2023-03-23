import 'dart:developer';
import 'package:break_app/screens/socialSingle.dart';
import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}

class Social extends StatefulWidget {
  const Social({super.key});
  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  bool loading = true;
  List<PhotoItem> users = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future _loadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<Map<String, dynamic>> files = [];
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url": fileUrl, //to pull image from firebase storage
        "path": file.fullPath, //to delete image on firebase storage
        "name": file.fullPath.split('.')[0],
      });
    });
    inspect(files);
    for (var i = 0; i < files.length; i++) {
      users.add(PhotoItem(files[i]['url'], files[i]['name']));
    }
    setState(() {
      loading = false;
    });
    inspect(loading);
    return;
  }

  @override
  Widget build(BuildContext context) {
    inspect(loading);
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 231, 235, 227),
            drawer: CustomDrawer(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Meet your friends",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E593F),
                  fontSize: 30,
                ),
              ),
              backgroundColor: Color(0xECEAEA),
              shadowColor: Color(0xECEAEA),
              surfaceTintColor: Color(0xECEAEA),
              foregroundColor: Color(0xECEAEA),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                children: [
                  //SEARCH BAR
                  Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Material(
                          color: Colors.transparent,
                          elevation: 10.0,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 27, 115, 97)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor:
                                      Color.fromARGB(255, 27, 115, 97))),
                        ),
                      ],
                    ),
                  ),

                  //GRID OF FRIENDS
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 20),
                        itemCount: users.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SocialSingle(users: users[index]),
                                      ));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    margin: EdgeInsetsDirectional.symmetric(
                                        vertical: 0),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Color.fromARGB(
                                                255, 27, 115, 97)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ],
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image:
                                              NetworkImage(users[index].image),
                                        ),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),

                              // Spacer(flex: 1,),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  users[index].name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 27, 115, 97)),
                                ),
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.bottomCenter,
                              )
                            ],
                          ));
                        }),
                  ))
                ],
              ),
            ));
  }
}

import 'package:break_app/firebase/database.dart';
import 'package:break_app/models/stats.dart';
import 'package:break_app/screens/socialSingle.dart';
import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';

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
  late breakUser bu;
  late List<String> friends;
  late profile user;
  late PhotoItem newFriend;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      user = Provider.of<profile>(context, listen: false);
      _loadFriends();
    });
  }

  Future deleteFriend(friendName) async {
    await bu.removeFriend(friendName);
    await DatabaseService().updateUser(bu, user.uid);
  }

  Future _loadFriends() async {
    bu = await DatabaseService().getUser(user.uid);
    friends = bu.meetups.keys.toList();
    final ListResult result = await _loadImages();
    final List<Reference> allFiles = result.items;
    List<Map<String, dynamic>> files = [];
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      var name = file.fullPath.split('.')[0];
      if (friends.contains(name)) {
        files.add({
          "url": fileUrl, //to pull image from firebase storage
          "path": file.fullPath, //to delete image on firebase storage
          "name": name,
        });
      }
    });
    for (var i = 0; i < files.length; i++) {
      users.add(PhotoItem(files[i]['url'], files[i]['name']));
    }
    setState(() {
      loading = false;
    });
    return;
  }

  Future<ListResult> _loadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref().list();
    return result;
  }

  Future searchFriend(name, context) async {
    var exists = await bu.addFriends(name);
    await DatabaseService().updateUser(bu, user.uid);
    if (!exists) {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('$name does not exist')));
    }
    final ListResult result = await _loadImages();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      var friendName = file.fullPath.split('.')[0];
      if (name == friendName) {
        newFriend = PhotoItem(fileUrl, name);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SocialSingle(
                    user: user, users: newFriend, deleteFriend: deleteFriend)));
      }
    });
  }

  TextEditingController searchNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                              controller: searchNameController,
                              onFieldSubmitted: (value) =>
                                  searchFriend(value, context),
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
                                          builder: (context) => SocialSingle(
                                              user: user,
                                              users: users[index],
                                              deleteFriend: deleteFriend)));
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

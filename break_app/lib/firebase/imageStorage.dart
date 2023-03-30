import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class imageStorage extends StatefulWidget {
  const imageStorage({super.key});

  @override
  State<imageStorage> createState() => _imageStorageState();
}

class _imageStorageState extends State<imageStorage> {
  bool loading = true;

  Future<List<Map<String, dynamic>>> _loadImages() async {
    final storageRef = FirebaseStorage.instance.ref();
    final profilesRef = storageRef.child("Profiles");
    final breathingRef = storageRef.child('Breathing Exercises');
    List<Map<String, dynamic>> files = [];
    //final ListResult result = await storage.ref().child("Profiles").list();
    final ListResult result = await breathingRef.list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      print(fileUrl);
      files.add({
        "url": fileUrl, //to pull image from firebase storage
        "path": file.fullPath, //to delete image on firebase storage
        "name": file.fullPath.split('.')[0],
      });
    });
    inspect(files);
    // setState(() {
    //   loading = false;
    // });
    loading = false;
    setState(() {});
    return files;
  }

  @override
  void initState() {
    _loadImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : const Center(
            child: Text('test'),
          );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class NetworkRepository {
  Future<String> uploadPhotoToFirebaseStorage(File imageFile) async {
    String fileName = basename(imageFile.path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref('images').child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    var url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  String basename(path) {
    return path.split('/').last;
  }

  //delete photo from firebase storage
  Future<void> deletePhotoFromFirebaseStorage(String url) async {
    var firebaseStorageRef = FirebaseStorage.instance.refFromURL(url);
    await firebaseStorageRef.delete();
  }

  //get all photos from firebase storage
  Future<List<String>> getAllPhotosFromFirebaseStorage() async {
    List<String> urls = [];
    var firebaseStorageRef = FirebaseStorage.instance.ref('images');
    var listResult = await firebaseStorageRef.listAll();
    for (var item in listResult.items) {
      var url = await item.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
}

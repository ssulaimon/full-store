import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UploadImage {
  static Future<String> uploadImage({
    required Uint8List image,
    required String category,
    required String itemName,
  }) async {
    late String imageUrl;
    var firebaseStorage = FirebaseStorage.instance.ref(category).child(
          itemName,
        );

    await firebaseStorage
        .putData(
      image,
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      imageUrl = await firebaseStorage.getDownloadURL();
    });
    return imageUrl;
  }
}

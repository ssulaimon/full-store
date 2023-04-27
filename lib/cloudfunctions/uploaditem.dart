import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fullstore/models/itemmodel.dart';

class UploadItem {
  static FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  static Future<void> uploadItem({required ItemModel itemModel}) async {
    await firebaseFirestore
        .collection(
          itemModel.category,
        )
        .add(
          itemModel.toJson(),
        );
  }
}

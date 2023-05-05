import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/models/ordermodel.dart';

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

  static Future<List<ItemModel>> getItems(
      {required String collectionPath}) async {
    late List<ItemModel> foods;
    await firebaseFirestore
        .collection(collectionPath)
        .get()
        .then((QuerySnapshot data) async {
      List items = data.docs;

      foods = List.generate(
        items.length,
        (index) => ItemModel(
            category: items[index]['category'],
            description: items[index]['description'],
            image: items[index]['image'],
            ingredients: items[index]['ingredients'],
            name: items[index]['name'],
            price: items[index]['price'],
            id: data.docs[index].reference.id),
      );
    });
    return foods;
  }

  static Future<void> deleteItem(
      {required String collectionPath, required String id}) async {
    await firebaseFirestore.collection(collectionPath).doc(id).delete();
  }

  static Future<List<ItemModel>> orders() async {
    late List<ItemModel> items;
    firebaseFirestore
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List documents = querySnapshot.docs;
      items = List.generate(
        documents.length,
        (index) => ItemModel(
            category: documents[index]['category'],
            description: documents[index]['description'],
            image: documents[index]['image'],
            ingredients: documents[index]['ingredients'],
            name: documents[index]['name'],
            price: documents[index]['price'],
            email: documents[index]['email'],
            address: documents[index]['address']),
      );
    });
    return items;
  }

  static Future<void> addToOrder({required OrderModel orderModel}) async {
    firebaseFirestore.collection('orders').add(
          orderModel.tojson(),
        );
  }

  static Future<List<Map>> myOrders() async {
    late List<Map> orders;
    await firebaseFirestore
        .collection('orders')
        .where("email", isEqualTo: UserAuthentication.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List item = querySnapshot.docs;

      orders = List.generate(item.length, (index) {
        List data = item[index]['items'];
        Timestamp date = item[index]["date"];
        return {
          "email": item[index]['email'],
          "date": date.toDate(),
          "transactionId": item[index]["transcationId"],
          "items": List.generate(
              data.length,
              (index) => ItemModel(
                  category: data[index]["category"],
                  description: "",
                  image: data[index]["image"],
                  ingredients: "",
                  name: data[index]["name"],
                  price: data[index]["price"]))
        };
      });
    });

    return orders;
  }

  static Future<List<Map>> allTranscation() async {
    late List<Map> transactions;
    await firebaseFirestore
        .collection("orders")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List items = querySnapshot.docs;
      transactions = List.generate(items.length, (index) {
        // List data = items[index]['items'];
        Timestamp date = items[index]["date"];
        return {
          "email": items[index]["email"],
          "transaction": items[index]["transcationId"],
          "status": items[index]["status"],
          "date": date.toDate()
        };
      });
    });
    return transactions;
  }
}

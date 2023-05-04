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

  static Future<List<OrderModel>> myOrders() async {
    List<OrderModel>? items;
    await firebaseFirestore
        .collection('orders')
        .where("email", isEqualTo: UserAuthentication.email)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      List orders = querySnapshot.docs;

      items = List.generate(orders.length, (index) {
        List products = orders[index]['items'];

        return OrderModel(
            dateTime: orders[index]['date'],
            email: orders[index]['email'],
            items: List.generate(
                products.length,
                (index) => ItemModel(
                    category: products[index]['category'],
                    description: '',
                    image: products[index]['image'],
                    ingredients: '',
                    name: products[index]['name'],
                    price: products[index]['price'])),
            status: orders[index]['status'],
            transcationId: orders[index]['transcationId']);
      });
    });
    print(items?.length);

    return items!;
  }
}

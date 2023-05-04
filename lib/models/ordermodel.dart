import 'package:fullstore/models/itemmodel.dart';

class OrderModel {
  String email;
  DateTime dateTime;
  String transcationId;
  String status;
  List<ItemModel> items;
  OrderModel({
    required this.dateTime,
    required this.email,
    required this.items,
    required this.status,
    required this.transcationId,
  });

  tojson() => {
        "email": email,
        "transcationId": transcationId,
        "status": status,
        "items": List.generate(
            items.length,
            (index) => {
                  "name": items[index].name,
                  "price": items[index].price,
                  "category": items[index].category,
                  "image": items[index].image,
                }),
        "date": dateTime,
      };
}

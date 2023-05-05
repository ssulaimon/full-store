import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/models/ordermodel.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/custombotton.dart';
import 'package:fullstore/widgets/itemscard.dart';

class OrdersUser extends StatelessWidget {
  const OrdersUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.white,
        title: Text(
          "Orders",
          style: TextStyle(color: MyColors.black),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error !!!',
                style: TextStyle(color: MyColors.black),
              ),
            );
          } else {
            List<Map> orders = snapshot.data as List<Map>;

            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async => showOrderItems(
                      context: context, items: orders[index]['items']),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transaction: ${orders[index]["transactionId"]}",
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text("Date: ${orders[index]["date"]}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            );
          }
        },
        future: UploadItem.myOrders(),
      ),
    );
  }
}

Future<void> showOrderItems(
    {required BuildContext context, required List<ItemModel> items}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 500,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          items[index].image,
                          height: 50,
                          width: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 180,
                              child: Expanded(
                                child: Text(
                                  items[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                              ),
                            ),
                            Text("₦${items[index].price}")
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
        );
      });
}

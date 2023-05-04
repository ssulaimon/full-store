import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/ordermodel.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/custombotton.dart';

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
            List<OrderModel> orders = snapshot.data as List<OrderModel>;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("Transction: ${orders[index].transcationId}"),
                          Text("Date: ${orders[index].dateTime.toString()}"),
                        ],
                      ),
                      CustomBotton(
                        backgroundColor: MyColors.primaryColor,
                        textColor: MyColors.white,
                        horizontal: 20,
                        vertical: 5,
                        title: "View more",
                      )
                    ],
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

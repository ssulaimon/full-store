import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/models/ordermodel.dart';
import 'package:fullstore/providers/shoppinglist.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/custombotton.dart';
import 'package:fullstore/widgets/customsnackbar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UserShoppingList extends StatelessWidget {
  const UserShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroudColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColors.black),
        elevation: 0.0,
        backgroundColor: MyColors.backgroudColor,
        title: Text(
          "My Shopping List",
          style: TextStyle(color: MyColors.black),
        ),
      ),
      body: Consumer<ShoppingList>(builder: (context, items, child) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: items.item.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            items.item[index].image,
                            height: 80,
                            width: 80,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items.item[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900),
                              ),
                              Text("₦${items.item[index].price}")
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              items.delete(index: index);
                              Provider.of<ShoppingLenght>(context,
                                      listen: false)
                                  .lenght = items.item.length;
                            },
                            icon: Icon(
                              Icons.delete,
                              color: MyColors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 100,
              ),
              child: CustomBotton(
                  onTap: () => checkout(items: items.item),
                  backgroundColor: MyColors.primaryColor,
                  textColor: MyColors.white,
                  horizontal: 30,
                  vertical: 20,
                  title: 'Checkout'),
            )
          ],
        );
      }),
    );
  }
}

void checkout({required List<ItemModel> items}) async {
  if (UserAuthentication.isVerified) {
    const uuid = Uuid();
    OrderModel orderModel = OrderModel(
      dateTime: DateTime.now(),
      email: UserAuthentication.email,
      items: items,
      status: "Pending",
      transcationId: uuid.v1(),
    );
    UploadItem.addToOrder(orderModel: orderModel);
  } else {
    customSnackBar(message: 'Please Verify Your account to continue');
  }
}

import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/providers/selecttable.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/dropdown.dart';
import 'package:fullstore/widgets/productscontainer.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Consumer<SelectTable>(builder: (context, selectTable, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CATEGORY'),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: CustomDropDown(
                      validator: (value) {},
                      hint: "Category",
                      onchanged: (value) {
                        selectTable.selectedValue = value;
                      },
                      items: selectTable.items,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<ItemModel> items = snapshot.data as List<ItemModel>;
                      return DataTable(
                          border: TableBorder.symmetric(
                              inside: BorderSide(color: MyColors.white)),
                          dataRowColor:
                              MaterialStateProperty.all(MyColors.black),
                          headingRowColor:
                              MaterialStateProperty.all(MyColors.lightBlue),
                          decoration: BoxDecoration(color: MyColors.white),
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Product Name',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Product Price',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Description',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                              ),
                            )
                          ],
                          rows: List.generate(
                              items.length,
                              (index) => DataRow(cells: [
                                    DataCell(Text(
                                      items[index].name,
                                      style: TextStyle(color: MyColors.white),
                                    )),
                                    DataCell(Text(
                                      items[index].price,
                                      style: TextStyle(color: MyColors.white),
                                    )),
                                    DataCell(Text(
                                      items[index].description,
                                      style: TextStyle(color: MyColors.white),
                                    )),
                                    DataCell(
                                      IconButton(
                                        onPressed: () async {
                                          await UploadItem.deleteItem(
                                            collectionPath:
                                                selectTable.selectedValue!,
                                            id: items[index].id!,
                                          );
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    )
                                  ])));
                    }
                  },
                  future: UploadItem.getItems(
                    collectionPath: selectTable.selectedValue.toString(),
                  ),
                ),
              )
            ],
          );
        }));
  }
}

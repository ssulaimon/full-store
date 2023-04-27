import 'package:flutter/material.dart';
import 'package:fullstore/providers/selecttable.dart';
import 'package:fullstore/widgets/dropdown.dart';
import 'package:fullstore/widgets/productscontainer.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({super.key});

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
                  CustomDropDown(
                    validator: (value) {},
                    hint: "Category",
                    onchanged: (value) {
                      selectTable.selectedValue = value;
                    },
                    items: selectTable.items,
                  )
                ],
              ),
              Expanded(child: Container())
            ],
          );
        }));
  }
}

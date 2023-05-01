import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/utils/colors.dart';

class Sales extends StatelessWidget {
  const Sales({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UploadItem.orders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.lightBlue,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: DataTable(
              border: TableBorder.symmetric(
                  inside: BorderSide(color: MyColors.white)),
              dividerThickness: 2.0,
              headingRowColor: MaterialStateProperty.all(MyColors.lightBlue),
              columns: const [
                DataColumn(
                  label: Text('Customer Name'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Item Name'),
                ),
                DataColumn(
                  label: Text('Status'),
                ),
                DataColumn(
                  label: Text('Category'),
                ),
                DataColumn(
                  label: Text('Price'),
                ),
              ],
              rows: [],
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/utils/colors.dart';

class Sales extends StatelessWidget {
  const Sales({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UploadItem.allTranscation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.lightBlue,
            ),
          );
        } else {
          List<Map> items = snapshot.data as List<Map>;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: DataTable(
              border: TableBorder.symmetric(
                  inside: BorderSide(color: MyColors.white)),
              dataRowColor: MaterialStateProperty.all(MyColors.black),
              headingRowColor: MaterialStateProperty.all(MyColors.lightBlue),
              decoration: BoxDecoration(color: MyColors.white),
              columns: const [
                DataColumn(
                  label: Text(
                    'Email',
                  ),
                ),
                DataColumn(
                  label: Text('Transcation ID'),
                ),
                DataColumn(
                  label: Text('Status'),
                ),
                DataColumn(
                  label: Text('Date'),
                ),
                DataColumn(
                  label: Text('View Items'),
                ),
              ],
              rows: List.generate(
                items.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      Text(items[index]["email"],
                          style: TextStyle(color: MyColors.white)),
                    ),
                    DataCell(
                      Text(items[index]["transaction"],
                          style: TextStyle(color: MyColors.white)),
                    ),
                    DataCell(
                      Text(items[index]["status"],
                          style: TextStyle(color: MyColors.white)),
                    ),
                    DataCell(
                      Text(items[index]["date"].toString(),
                          style: TextStyle(color: MyColors.white)),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.preview,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

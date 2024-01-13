
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/common/button.dart';

class ListOfData extends StatefulWidget {
  List<String> checklistItems ; // List to store the checklist items
  ListOfData({required this.checklistItems});

  @override
  _ListOfDataState createState() => _ListOfDataState();
}

class _ListOfDataState extends State<ListOfData> {
  // List<String> selectedItems = []; // List to store the selected items

  // void toggleItemSelection(int index, bool value) {
  //   setState(() {
  //     final item = widget.checklistItems[index];
  //     if (value) {
  //       selectedItems.add(item);
  //     } else {
  //       selectedItems.remove(item);
  //     }
  //   });
  // }
  //
  // void saveSelectedData() {
  //   // Perform actions to save the selected data
  //   print('Selected Items: $selectedItems');
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.checklistItems.length,
      itemBuilder: (context, index) {
        final item = widget.checklistItems[index];

        return Column(
          children: [
            Text(item, style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),

          ],
        );
        // return CheckboxListTile(
        //   title: Text(item, style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
        //   value: selectedItems.contains(item),
        //   onChanged: (value) {
        //     toggleItemSelection(index, value!);
        //   },
        // );
      },
    );
  }
}

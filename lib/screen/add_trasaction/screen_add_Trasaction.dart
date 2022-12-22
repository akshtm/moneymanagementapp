import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenAddTrasaction extends StatefulWidget {
  const ScreenAddTrasaction({Key? key}) : super(key: key);
  static const routeName = 'add-transaction';

  @override
  State<ScreenAddTrasaction> createState() => _ScreenAddTrasactionState();
}

class _ScreenAddTrasactionState extends State<ScreenAddTrasaction> {
  DateTime? _selected_date;
  CategoryType? _selectedCategory;
  CategoryModel? _selectedcategoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: 'Purpose'),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Amount'),
          ),
          TextButton.icon(
              onPressed: () async {
                final selectedateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now());
                if (selectedateTemp == null) {
                  return;
                } else {
                  setState(() {
                    _selected_date = selectedateTemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selected_date == null
                  ? 'SELECT DATE'
                  : _selected_date.toString())),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: CategoryType.income,
                      onChanged: (newvalue) {}),
                  Text('Income')
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expence,
                      groupValue: CategoryType.income,
                      onChanged: (newvalue) {}),
                  Text('Expence')
                ],
              ),
            ],
          ),
          DropdownButton(
              hint: Text('Select category'),
              items: categoryDB().IncomeCategoryListener.value.map((e) {
                return DropdownMenuItem(value: e.name, child: Text(e.name));
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
              }),
          ElevatedButton(onPressed: () {}, child: Text('Submit'))
        ],
      ),
    )));
  }
}

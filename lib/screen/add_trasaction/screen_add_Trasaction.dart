import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/trasaction/trasaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';

class ScreenAddTrasaction extends StatefulWidget {
  const ScreenAddTrasaction({Key? key}) : super(key: key);
  static const routeName = 'add-transaction';

  @override
  State<ScreenAddTrasaction> createState() => _ScreenAddTrasactionState();
}

class _ScreenAddTrasactionState extends State<ScreenAddTrasaction> {
  DateTime? _selected_date;
  String? _category_id;
  CategoryType? _selectedCategory;
  CategoryModel? _selectedcategoryModel;
  @override
  void initState() {
    _selectedCategory = CategoryType.income;
    super.initState();
  }

  final _PourposeTextEDitingController = TextEditingController();
  final _amountTextEDitingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: _PourposeTextEDitingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: 'Purpose'),
          ),
          TextFormField(
            controller: _amountTextEDitingController,
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
                      groupValue: _selectedCategory,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedCategory = CategoryType.income;
                          _category_id = null;
                        });
                      }),
                  Text('Income')
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expence,
                      groupValue: _selectedCategory,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedCategory = CategoryType.expence;
                          _category_id = null;
                        });
                      }),
                  Text('Expence')
                ],
              ),
            ],
          ),
          DropdownButton<String>(
            hint: Text('Select Value'),
            value: _category_id,
            items: (_selectedCategory == CategoryType.income
                    ? categoryDB().IncomeCategoryListener
                    : categoryDB().ExpenseCategoryListener)
                .value
                .map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
                onTap: () {
                  _selectedcategoryModel = e;
                },
              );
            }).toList(),
            onChanged: (selectedValue) {
              print(selectedValue);
              setState(() {
                _category_id = selectedValue;
              });
            },
            onTap: () {},
          ),
          ElevatedButton(
              onPressed: () {
                addTrasaction();
              },
              child: Text('Submit'))
        ],
      ),
    )));
  }

  Future<void> addTrasaction() async {
    final _purposeText = _PourposeTextEDitingController.text;
    final _amountText = _amountTextEDitingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_selectedcategoryModel == null) {
      return;
    }
    if (_selected_date == null) {
      return;
    }

    final _parsedamount = double.tryParse(_amountText);
    if (_parsedamount == null) {
      return;
    }

    final _model = transaction_Model(
        pourpose: _purposeText,
        amount: _parsedamount,
        date: _selected_date!,
        type: _selectedCategory!,
        category: _selectedcategoryModel!);

    transactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    transactionDB.instance.refreshTras();
  }
}

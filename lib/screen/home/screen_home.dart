import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screen/add_trasaction/screen_add_Trasaction.dart';
import 'package:money_manager/screen/category/category_add_popup.dart';
import 'package:money_manager/screen/category/screen_category.dart';
import 'package:money_manager/screen/home/widgets/bottom_navigation.dart';
import 'package:money_manager/screen/transaction/screen_transaction.dart';

class Screen_Home extends StatelessWidget {
  Screen_Home({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [Screen_Transaction(), Screen_Category()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: const Bottom_Navigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTrasaction.routeName);
            print('add trans');
          } else {
            showCategoryAddPopup(context);
            // print('addcategry');
            // final sample = CategoryModel(
            //     id: DateTime.now().microsecond.toString(),
            //     name: 'Travel',
            //     type: CategoryType.expence);
            // categoryDB().insertCategory(sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

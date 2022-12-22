import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class expense_category_list extends StatelessWidget {
  const expense_category_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDB().ExpenseCategoryListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: Icon(Icons.delete),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length);
        });
  }
}

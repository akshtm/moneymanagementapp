import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> Selected_Category_notifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final namediting_controller = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: namediting_controller,
                decoration: const InputDecoration(
                    hintText: 'Category Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Radio_Button(type: CategoryType.income, title: 'Income'),
                  Radio_Button(type: CategoryType.expence, title: 'Expence')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final name = namediting_controller.text;
                    if (name.isEmpty) {
                      return;
                    }
                    final type = Selected_Category_notifier.value;

                    final category = CategoryModel(
                        id: DateTime.now().millisecond.toString(),
                        name: name,
                        type: type);
                    categoryDB.instance.insertCategory(category);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add')),
            )
          ],
        );
      });
}

class Radio_Button extends StatelessWidget {
  final String title;
  final CategoryType type;

  const Radio_Button({Key? key, required this.type, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: Selected_Category_notifier,
            builder: (BuildContext ctx, CategoryType newcatogory, Widget_) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: Selected_Category_notifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    Selected_Category_notifier.value = value;
                    Selected_Category_notifier.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}

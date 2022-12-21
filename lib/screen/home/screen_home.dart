import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            print('add trans');
          } else {
            print('add cate');
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screen/category/expense_category_list.dart';
import 'package:money_manager/screen/category/income_category_list.dart';

class Screen_Category extends StatefulWidget {
  Screen_Category({Key? key}) : super(key: key);

  @override
  State<Screen_Category> createState() => _Screen_CategoryState();
}

class _Screen_CategoryState extends State<Screen_Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        tabs: [
          Tab(
            text: 'INCOME',
          ),
          Tab(
            text: 'EXPENCE',
          ),
        ],
      ),
      Expanded(
        child: TabBarView(
            controller: _tabController,
            children: [Income_category_list(), expense_category_list()]),
      )
    ]);
  }
}

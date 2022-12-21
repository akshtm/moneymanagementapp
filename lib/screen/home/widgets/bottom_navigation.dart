import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screen/home/screen_home.dart';

class Bottom_Navigation extends StatelessWidget {
  const Bottom_Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Screen_Home.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedindex, _) {
        return BottomNavigationBar(
            currentIndex: updatedindex,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            onTap: (newIndex) {
              Screen_Home.selectedIndexNotifier.value = newIndex;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category')
            ]);
      },
    );
  }
}

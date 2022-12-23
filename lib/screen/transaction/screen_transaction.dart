import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/trasaction/trasaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';

class Screen_Transaction extends StatelessWidget {
  const Screen_Transaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactionDB.instance.refreshTras();
    return ValueListenableBuilder(
        valueListenable: transactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext ctx, List<transaction_Model> newList, Widget? _) {
          return ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final value = newList[index];
                return Slidable(
                  key: Key(value.id!),
                  startActionPane:
                      ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        transactionDB.instance.deleteTransaction(value.id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                    )
                  ]),
                  child: Card(
                      shadowColor: value.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: value.type == CategoryType.income
                                  ? Colors.green
                                  : Colors.red,
                              radius: 50,
                              child: Text(parsedate(value.date),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 18, 17, 17)))),
                          title: Text(
                            '₹${value.amount}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(value.category.name),
                          trailing: Text(
                            value.pourpose,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ))),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}

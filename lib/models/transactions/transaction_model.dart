import 'dart:ffi';

import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class transaction_Model {
  @HiveField(0)
  final String pourpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? id;

  transaction_Model(
      {required this.pourpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

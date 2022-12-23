import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TrasactionDbfunctions {
  Future<void> addTransaction(transaction_Model obj);
  Future<List<transaction_Model>> getAllData();
  Future<void> deleteTransaction(String id);
}

class transactionDB implements TrasactionDbfunctions {
  transactionDB._instance();
  static transactionDB instance = transactionDB._instance();
  factory transactionDB() {
    return instance;
  }
  ValueNotifier<List<transaction_Model>> transactionListNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(transaction_Model obj) async {
    log(obj.toString());
    final _db = await Hive.openBox<transaction_Model>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }

  Future<void> refreshTras() async {
    final _list = await getAllData();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<transaction_Model>> getAllData() async {
    final _db = await Hive.openBox<transaction_Model>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<transaction_Model>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refreshTras();
  }
}

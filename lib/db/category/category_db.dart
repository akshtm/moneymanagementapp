import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screen/category/expense_category_list.dart';
import 'package:money_manager/screen/category/income_category_list.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String CategoryId);
}

class categoryDB implements CategoryDbFunctions {
  /// CREATING SINGLETON
  categoryDB.internal();
  static categoryDB instance = categoryDB.internal();

  factory categoryDB() {
    return instance;
  }
////
  ValueNotifier<List<CategoryModel>> IncomeCategoryListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> ExpenseCategoryListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);

    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final getallCategories = await getCategories();
    IncomeCategoryListener.value.clear();
    ExpenseCategoryListener.value.clear();
    log('clear legth Income' + IncomeCategoryListener.value.length.toString());
    log('clear legth Expense' +
        ExpenseCategoryListener.value.length.toString());

    await Future.forEach(getallCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        log("income -----");
        log("category type ===" + category.type.toString());

        IncomeCategoryListener.value.add(category);
      } else if (category.type == CategoryType.expence) {
        log("expense ======");
        log("category type ===" + category.type.toString());
        ExpenseCategoryListener.value.add(category);
      }
    });
    log(IncomeCategoryListener.value.length.toString());

    IncomeCategoryListener.notifyListeners();
    ExpenseCategoryListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String CategoryId) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    await _categoryDB.delete(CategoryId);
    log(_categoryDB.values.length.toString());
    refreshUI();
  }
}

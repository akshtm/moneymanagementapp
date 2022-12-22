import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screen/category/expense_category_list.dart';
import 'package:money_manager/screen/category/income_category_list.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
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
    await _categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final getallCategories = await getCategories();

    await Future.forEach(getallCategories, (CategoryModel category) {
      IncomeCategoryListener.value.clear;
      ExpenseCategoryListener.value.clear;
      if (category.type == CategoryType.income) {
        IncomeCategoryListener.value.add(category);
      } else {
        ExpenseCategoryListener.value.add(category);
      }
    });

    IncomeCategoryListener.notifyListeners();
    ExpenseCategoryListener.notifyListeners();
  }
}

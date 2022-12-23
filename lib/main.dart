import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';
import 'package:money_manager/screen/add_trasaction/screen_add_Trasaction.dart';
import 'package:money_manager/screen/home/screen_home.dart';

Future<void> main() async {
  final obj1 = categoryDB();
  final obj2 = categoryDB();
  print('objects are comparing');
  print(obj1 == obj2);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionModelAdapter().typeId)) {
    Hive.registerAdapter(transactionModelAdapter());
  }
  categoryDB().refreshUI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen_Home(),
      routes: {
        ScreenAddTrasaction.routeName: (ctx) => const ScreenAddTrasaction()
      },
    );
  }
}

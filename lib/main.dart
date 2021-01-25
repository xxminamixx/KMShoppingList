import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItem.dart';
import 'package:km_shopping_list/Widget/BottomNavigationWidget.dart';


void main() async {
  // Hiveの初期化
  await Hive.initFlutter();
  Hive.registerAdapter(ShoppingItemAdapter());
  await Hive.openBox<ShoppingItem>('shoppingItem');
  runApp(KMShoppingList());
}

class KMShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '買い物リスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavigationWidget(),
    );
  }
}

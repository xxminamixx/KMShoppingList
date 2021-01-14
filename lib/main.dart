import 'package:flutter/material.dart';
import 'package:km_shopping_list/Widget/BottomNavigationWidget.dart';


void main() {
  runApp(KMShoppingList());
}

class KMShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '買い物リスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavigationWidget(),
    );
  }
}

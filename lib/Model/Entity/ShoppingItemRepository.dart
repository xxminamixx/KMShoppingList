import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItem.dart';

class ShoppingItemRepository {

  ShoppingItemBox _shoppingItemBox;

  ShoppingItemRepository({
    @required shoppingItemBox
  }) {
    this._shoppingItemBox = _shoppingItemBox;
  }

  Future<void> save({
    @required ShoppingItem shoppingItem,
  }) async {
    // final box = await _shoppingItemBox.box;
    final box = await Hive.openBox<ShoppingItem>('shoppingItem');
    await box.add(shoppingItem);
  }

  Future<void> delete({
    @required ShoppingItem shoppingItem,
  }) async {
    final box = await Hive.openBox<ShoppingItem>('shoppingItem');
    int deleteItemIndex = -1;
    box.values.toList().asMap().forEach((index, item) {
      if (item.name == shoppingItem.name) {
        deleteItemIndex = index;
      }
    });

    if (deleteItemIndex < 0) { return; }

    box.deleteAt(deleteItemIndex);
  }

  Future<List<ShoppingItem>> fetchAll() async {
    // final box = await _shoppingItemBox.box;
    final box = await Hive.openBox<ShoppingItem>('shoppingItem');
    return box.values.toList();
  }

  /* チェックがついてるアイテムを全て削除して残ったItemsを返却する */
  Future<List<ShoppingItem>> cleanItems() async {
    final box = await Hive.openBox<ShoppingItem>('shoppingItem');
    box.values.forEach((item) async {
     if (item.checked) {
       await item.delete();
     }
    });
    return box.values.toList();
  }

}
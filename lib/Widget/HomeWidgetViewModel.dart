import 'package:flutter/cupertino.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItem.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItemRepository.dart';

class HomeWidgetViewModel extends ChangeNotifier {

  List<ShoppingItem> shoppingItems = [];
  /* List の更新だとリビルドされないので更新検知のためのダミー変数 */
  int dummy = 0;

  HomeWidgetViewModel({
    @required List<ShoppingItem> shoppingItems,
  }) {
    this.shoppingItems = shoppingItems;
    this.dummy = shoppingItems.length;
  }

  void add(ShoppingItem shoppingItem) async {
    shoppingItems.add(shoppingItem);
    dummy = dummy + 1;
    notifyListeners();
  }

  void remove(ShoppingItem shoppingItem) {
    shoppingItems.remove(shoppingItem);
    notifyListeners();
  }

  void changeAll(List<ShoppingItem> shoppingItems) {
    this.shoppingItems = shoppingItems;
    dummy = dummy + 1;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
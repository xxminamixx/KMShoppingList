import 'package:hive/hive.dart';

part 'ShoppingItem.g.dart';

@HiveType(typeId: 1)
class ShoppingItem extends HiveObject {

  ShoppingItem(this.name, this.checked);

  @HiveField(0)
  String name;

  @HiveField(1)
  bool checked;

}

class ShoppingItemBox {

  // static const String _shoppingItemKey = 'shoppingItem';

  final box = Hive.openBox<ShoppingItem>('shoppingItem');
}
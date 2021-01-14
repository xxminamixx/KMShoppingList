import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItem.dart';

class HomeWidget extends StatelessWidget {

  List<ShoppingItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: _items(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addButtonTapped(context),
      ),
    );
  }

  List<Widget> _items() {
    if (items.isEmpty) { return []; }
    return items.map((item) => _item(item) ).toList();
  }

  Widget _item(ShoppingItem item) {
    return Container(
      child: Card(
        child: Row(
          children: [
            Checkbox(
                value: item.checked,
                onChanged: _changeCheckBoxValue,
            ),
            Text(item.name),
          ],
        ),
      ),
    );
  }

  void _addButtonTapped(BuildContext context) async {
    final inputText = await showTextInputDialog(context: context, textFields: [
      DialogTextField(
        hintText: '追加したい内容を入力してください',
        validator: (value) => value.isEmpty ? '入力が空です' : null,
      ),
    ]);

    if (inputText?.isEmpty ?? true) { return; }

    final shoppingItem = ShoppingItem(inputText.first, false);
    this.items.add(shoppingItem);
    // TODO: リスト更新
  }

  void _changeCheckBoxValue(bool isChecked) {

  }

}
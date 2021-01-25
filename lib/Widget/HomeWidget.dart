import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItem.dart';
import 'package:km_shopping_list/Model/Entity/ShoppingItemRepository.dart';
import 'package:km_shopping_list/Utility/Widget/WebViewWidget.dart';
import 'package:km_shopping_list/Widget/HomeWidgetViewModel.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {

  final repository = ShoppingItemRepository(shoppingItemBox: ShoppingItemBox());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: repository.cleanItems(),
        builder: (futureContext, snapshot) {
          if (snapshot.hasData)  {
            return ChangeNotifierProvider(
              create: (_) => HomeWidgetViewModel(shoppingItems: snapshot.data),
              builder: (childContext, widget) {
                // shoppingItemsを監視
                final dummy = childContext.select((HomeWidgetViewModel viewModel) => viewModel.dummy);
                final shoppingItems = childContext.select((HomeWidgetViewModel viewModel) => viewModel.shoppingItems);
                return _mainWidget(childContext, shoppingItems);
              },
            );
          } else {
            return Container();
          }
        }
    );
  }

  Widget _mainWidget(BuildContext context, List<ShoppingItem> items) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('買い物リスト',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: _items(context, items),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addButtonTapped(context),
      ),
    );
  }

  List<Widget> _items(BuildContext context, List<ShoppingItem> items) {
    print("count: ${items.length}");
    if (items.isEmpty) { return []; }
    final margin = Container(height: 16,);
    List results = items.map((item) => _item(context, item) ).toList();
    results.insert(0, margin);
    return results;
  }

  Widget _item(BuildContext context, ShoppingItem item) {
    return Container(
      child: Card(
        margin: EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
        child: Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child:  Checkbox(
                  value: item.checked,
                  onChanged: (isChecked){
                    _changeCheckBoxValue(context, item, isChecked);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Text(item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 24,
                width: 24,
                child: GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () { _searchButtonTapped(context, item.name); },
                ),
              ),
            ],
          ),
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
    // リストに追加
    context.read<HomeWidgetViewModel>().add(shoppingItem);
    repository.save(shoppingItem: shoppingItem);
  }

  void _changeCheckBoxValue(BuildContext context, ShoppingItem item, bool isChecked) async {
    item.checked = isChecked;
    await item.save();
    final items = await _getItems(context);
    // 総入れ替え
    context.read<HomeWidgetViewModel>().changeAll(items);
  }
  
  Future<void> _searchButtonTapped(BuildContext context, String itemName) async {
    final result = Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebViewWidget(url: "https://www.amazon.co.jp/s?k=$itemName", title: itemName,)
    ));
    print(result);
  }

  Future<List<ShoppingItem>> _getItems(BuildContext context) async {
    return repository.fetchAll();
  }

}